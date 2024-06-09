class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # has_many :items
  # has_many :purchases
  # has_many :comments
  validates :encrypted_password, length: { minimum: 6 }
  validates :nickname, presence: true
  validates :kanji_name_sei, presence: true
  validates :kanji_name_mei, presence: true
  validates :kana_name_sei, presence: true
  validates :kana_name_mei, presence: true
  validates :birthday, presence: true
end
