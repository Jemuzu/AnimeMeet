class User < ActiveRecord::Base
  validates :name, :email, :birth, :password, presence: true
      validates :email, uniqueness: true
      validates :password, length: {minimum: 5, maximum: 10}

      has_many :posts, dependent: :destroy
end

class Post < ActiveRecord::Base
      belongs_to :user
end
