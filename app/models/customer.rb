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
  validate :validate_postcode
  validates :address, presence: true
  validate :validate_telephone_number
  validates :email, presence: true, uniqueness: true

  def self.looks(word)
    where("last_name LIKE :word OR first_name LIKE :word OR last_name_kana LIKE :word OR first_name_kana LIKE :word", word: "%#{word}%")
  end

  private

  def validate_telephone_number
    if telephone_number.blank?
      errors.add(:telephone_number, "を入力してください")
    elsif telephone_number.match?(/\D/)
      errors.add(:telephone_number, "は数字で入力してください")
    elsif telephone_number.length != 10 && telephone_number.length != 11
      errors.add(:telephone_number, "は10桁または11桁の数字で入力してください")
    end
  end

  def validate_postcode
    if postcode.blank?
      errors.add(:postcode, "を入力してください")
    elsif postcode.match?(/\D/)
      errors.add(:postcode, "は数字で入力してください")
    elsif postcode.length != 7
      errors.add(:postcode, "は7桁の数字で入力してください")
    end
  end
end
