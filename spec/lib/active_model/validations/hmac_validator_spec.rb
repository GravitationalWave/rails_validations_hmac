require 'spec_helper'

describe ActiveModel::Validations::HmacValidator do

  subject { described_class.new(attributes: {}) }

  it "calls validate_each when hmac specified" do
    class Post
      validates :hmac, hmac: {key: :'api_user.secret', data: [:body, :title]}
    end

    post = Post.new(hmac: 'a', title: 'a', body: 'a')
    described_class.any_instance.should_receive(:validate_each).with(post, :hmac, 'a')

    post.valid?
  end

  describe "#value_in_context" do
    context "evaluatable type" do
      before do
        @c = "result"
        @b = mock(:b)
        @a = mock(:a)
        @record = Post.new
        @record.should_receive(:a).and_return(@a)
        @a.should_receive(:b).and_return(@b)
        @b.should_receive(:c).and_return(@c)
      end
      it "supports Symbol value" do
        r = subject.send(:value_in_context, @record, :'a').b.c
        r.should eq @c
      end
      it "supports Symbol values (with tree support using .)" do
        r = subject.send(:value_in_context, @record, :'a.b.c')
        r.should eq @c
      end
      it "supports Proc" do
        r = subject.send(:value_in_context, @record, lambda { a.b.c })
        r.should eq @c
      end
      it "supports Arrays (evaluates its elements and concats)" do
        r = subject.send(:value_in_context, @record, [lambda { a.b.c }])
        r.should eq @c
      end
    end
    context "unevaluatable type" do
      it "returns other types untouched" do
        r = subject.send(:value_in_context, @record, @c)
        r.should eq @c
      end
    end
  end

  describe "#validate_each" do
    context "valid hmac" do
      it "does not add error" do
        @p = Post.new(hmac: 'a', title: 'a', body: 'a')
        @p.valid?
      end
    end
    context "invalid hmac" do
      it "adds an error" do
      end
    end
  end



end
