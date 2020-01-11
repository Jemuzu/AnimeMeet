class User < ActiveRecord::Base
    validates :name, :email, :birth, :password, presence: true
    validates :email, uniqueness: true
    validates :password, length: {minimum: 3, maximum: 8}
    has_many :posts,dependent: :destroy
end

class Post < ActiveRecord::Base
    validates :content, length: {minimum: 1, maximum: 255}
    belongs_to :user
end
