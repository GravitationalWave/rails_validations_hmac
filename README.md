Intro
=====

Runs fast using OpenSSL::HMAC.


Supports
--------

* ActiveRecord
* On creating Issue and requesting, for other ORMs also



Usage
=====

```ruby
class Post < ActiveRecord::Base

  API_FIELDS = [:title, :body].sort                             # alphabetic order

  attr_accessible :api_user_id, :hmac
  attr_accessible *MESSAGE_FIELDS

  belongs_to :api_user

  validate :hmac, precence: true, hmac: {
    secret:   lambda { api_user.secret },                           
    content:  lambda { API_FIELDS.collect{|m| send(m) }.join }
  }

end
```


Valid options
-------------

* secret (Lambda) required
* content (Lambda) required
* message (String) optional (Example: 'ivalid')
* digest (Symbol) optional (Default: :sha1; Available: :md5, :sha, :sha1, :sha224, :sha384, :sha512)


Read more
=========

* http://en.wikipedia.org/wiki/Hash-based_message_authentication_code
* http://blog.nathanielbibler.com/post/63031273/openssl-hmac-vs-ruby-hmac-benchmarks
* http://ruby-doc.org/stdlib-1.9.3/libdoc/openssl/rdoc/OpenSSL/HMAC.html
* http://ruby-doc.org/stdlib-1.9.3/libdoc/openssl/rdoc/OpenSSL/Digest.html
