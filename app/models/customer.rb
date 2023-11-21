class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :postcode, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true
  validates :email, presence: true, uniqueness: true

  def self.looks(word)
    where("last_name LIKE :word OR first_name LIKE :word OR last_name_kana LIKE :word OR first_name_kana LIKE :word", word: "%#{word}%")
  end
end
