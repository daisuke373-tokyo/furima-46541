class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /@/, message: 'は@を含む必要があります' }
  validates :password, presence: true, length: { minimum: 6 },
                       format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'は半角英数字混合での入力が必須です' },
                       confirmation: true
  validates :password_confirmation, presence: true
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角での入力が必須です' }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角での入力が必須です' }
  validates :kana_last_name, presence: true, format: { with: /\A[ァ-ヶ]+\z/, message: 'は全角カタカナでの入力が必須です' }
  validates :kana_first_name, presence: true, format: { with: /\A[ァ-ヶ]+\z/, message: 'は全角カタカナでの入力が必須です' }
  validates :date_of_birth, presence: true
end
