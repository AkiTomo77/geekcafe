class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


   has_many :messages, dependent: :destroy
   has_many :entries, dependent: :destroy
   has_many :posts, dependent: :destroy
   has_many :likes, dependent: :destroy
   has_many :liked_posts, through: :likes, source: :post
   has_many :comments, dependent: :destroy
   has_many :relationships
   has_many :followings, through: :relationships, source: :follow
   has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
   has_many :followers, through: :reverse_of_relationships, source: :user

   validates :name, presence: true 
   validates :profile, length: { maximum: 200 }

  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

  mount_uploader :image, ImageUploader

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

end
