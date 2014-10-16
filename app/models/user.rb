class User < ActiveRecord::Base
  has_secure_password
  has_many :boards, dependent: :destroy
end
