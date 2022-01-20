class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :birth_date
  end

  PASSWORD_RULES = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i
  NAME_RULES = /\A[ぁ-んァ-ヶー-龠々ー]+\z/
  NAME_READ_RULES = /\A[ァ-ヶー]+\z/

  validates :password, format: { with: PASSWORD_RULES, message: "must be alphanumeric" }
  validates :last_name, presence: true, format: { with: NAME_RULES, message: "Full-width Japanese only" }
  validates :first_name, presence: true, format: { with: NAME_RULES, message: "Full-width Japanese only" }
  validates :last_name_read, presence: true, format: { with: NAME_READ_RULES, message: "Full-width katakana only" }
  validates :first_name_read, presence: true, format: { with: NAME_READ_RULES, message: "Full-width katakana only" }

  belongs_to :user

end
