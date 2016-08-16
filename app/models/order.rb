class Order < ApplicationRecord

  belongs_to :user

  validates :billing_name, presence: true
  validates :billing_address, presence: true
  validates :shopping_name, presence: true
  validates :shopping_address, presence: true

  has_many :product_lists

before_create :generate_token

  def generate_token
    self.token = SecureRandom.uuid
  end

  def pay_status
    if self.is_paid
      "已支付"
    else
      "未支付"
    end
  end

end
