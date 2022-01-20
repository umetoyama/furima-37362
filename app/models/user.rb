class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :birth_date
  end

  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: "must be alphanumeric" }
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶー-龠々ー]+\z/, message: "Full-width Japanese only" }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶー-龠々ー]+\z/, message: "Full-width Japanese only" }
  validates :last_name_read, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: "Full-width katakana only" }
  validates :first_name_read, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: "Full-width katakana only" }
end
