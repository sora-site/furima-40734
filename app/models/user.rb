class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # has_many :items
  # has_many :purchases
  # has_many :comments

  VALID_PASSWORD_REGEX = /\A(?=.*[a-z]\d)[a-z\d]{6,128}\z/ # 文字数はデフォルト
  VALID_KANJI_NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々]+\z/
  VALID_KANA_NAME_REGEX = /\A[ァ-ヶ一]+\z/

  validates :password, format: { with: VALID_PASSWORD_REGEX }
  validates :nickname, presence: true
  validates :kanji_name_sei, presence: true, format: { with: VALID_KANJI_NAME_REGEX }
  validates :kanji_name_mei, presence: true, format: { with: VALID_KANJI_NAME_REGEX }
  validates :kana_name_sei, presence: true, format: { with: VALID_KANA_NAME_REGEX }
  validates :kana_name_mei, presence: true, format: { with: VALID_KANA_NAME_REGEX }
  validates :birthday, presence: true
end
