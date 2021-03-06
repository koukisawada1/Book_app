class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :books, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :introduction, presence: false, length: {maximum: 50}

  validates :name, presence: true, length: {in: 2..20}

  def favorited_by?(user)
            favorites.where(user_id: user.id).exists?
   end
end
