class User < ActiveRecord::Base
    validates :first_name, :last_name, :email, :birthday, :password, presence: true
    validates :email, uniqueness: true
    validates :password, length: {minimum: 3, maximum: 8}
end
