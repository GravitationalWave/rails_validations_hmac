class CreateTablePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :api_user
      t.string :hmac
      t.string :title
      t.string :body
    end
  end
end
