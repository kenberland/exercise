class User < ApplicationRecord
  has_secure_password
  has_one :w9_form
end
