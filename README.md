Intro
=====
Runs fast using OpenSSL::HMAC.

Supports
--------
* ORMs and DOMs that use ActiveModel [hmac_validator.rb (30 sloc)](https://github.com/tione/rails_validations_hmac/blob/master/lib/rail
* If support for something is missing, add an issue and the support will be added

Usage
=====
```ruby

class ApiUser < ActiveRecord::Base
  has_many :posts
  validates :secret, presence: true
  validates :secret_algorithm, presence: true
end

class Post < ActiveRecord::Base
  API_FIELDS = [:title, :body].sort  # keep them in alphabetic order!
  attr_accessible :api_user_id, :hmac
  attr_accessible *MESSAGE_FIELDS
  belongs_to :api_user

  # these have same meaning (supports Lambdas and Symbols evaluating):
  validate :hmac, precence: true, hmac: {
    secret:     lambda { api_user.secret },
    content:    lambda { API_FIELDS.collect{|m| send(m) }.join },
    algorithm:  lambda { api_user.secret_algorithm }
  }

  validates :hmac, presence: true, hmac: {
    secret:     :'api_user.secret',
    content:     API_FIELDS,
    algorithm:  :'api_user.secret_algorithm'
  }

  # these are not evaluated (presumed that static value is written)
  validates :hmac, presence: true, hmac: {
    secret:     'all_the_time_same',
    content:    'why you would like to have a static value here?',
    algorithm:  'md5' # by default its sha1
  }
end
```

Valid options
-------------
* key (required) - secret preshared key
* data (required) - data to be controlled with HMAC
* algorithm (optional) -  by default 'sha1', 'md5', 'sha256', 'sha384', 'sha512' also supported
* message (optional) - errormessage to be shown if HMAC validation fails


Read more
=========
* http://en.wikipedia.org/wiki/Hash-based_message_authentication_code
* http://blog.nathanielbibler.com/post/63031273/openssl-hmac-vs-ruby-hmac-benchmarks
* http://ruby-doc.org/stdlib-1.9.3/libdoc/openssl/rdoc/OpenSSL/HMAC.html
* http://ruby-doc.org/stdlib-1.9.3/libdoc/openssl/rdoc/OpenSSL/Digest.html
