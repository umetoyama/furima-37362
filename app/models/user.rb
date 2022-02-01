class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :birth_date
  end

  PASSWORD_RULES = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  NAME_RULES = /\A[ぁ-んァ-ヶー-龠々ー]+\z/
  NAME_READ_RULES = /\A[ァ-ヶー]+\z/

  validates :password, format: { with: PASSWORD_RULES, message: 'は英数字のみです' }
  validates :last_name, presence: true, format: { with: NAME_RULES, message: 'は全角日本語のみです' }
  validates :first_name, presence: true, format: { with: NAME_RULES, message: 'は全角日本語のみです' }
  validates :last_name_read, presence: true, format: { with: NAME_READ_RULES, message: 'は全角カタカナのみです' }
  validates :first_name_read, presence: true, format: { with: NAME_READ_RULES, message: 'は全角カタカナのみです' }

  has_many :items
  has_many :orders
end
