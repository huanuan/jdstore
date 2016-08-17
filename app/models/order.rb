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

  include AASM

  assm do
    state :order_placed, initial: true
    stste :paid
    state :shopping
    state :shoped
    state :order_cancelled
    state :good_returned

    event :make_payment do
      transitions from: :order_placed, to: :paid
    end

    event :ship do
      translations from: :paid,         to: :shopping
    end

    event :deliver do
      transitions from: :shopping,      to: :shopped
    end

    event :return_good do
      transitions from: :shopped,       to: :good_returned
    end

    event :cancell_order do
      transitions from: [:order_placed, :paid], to: :order_cancelled
    end


  end

end
