class Order < ApplicationRecord

  belongs_to :user

  validates :billing_name, presence: true
  validates :billing_address, presence: true
  validates :shipping_name, presence: true
  validates :shipping_address, presence: true

  has_many :product_lists

  before_create :generate_token

  def generate_token
    self.token = SecureRandom.uuid
  end


  def order_status
    if self.aasm_state == "order_placed"
      "未支付"
    elsif self.aasm_state == "paid"
      "已支付"
    elsif self.aasm_state == "shipping"
      "出货中"

    elsif self.aasm_state == "shipped"
      "已到货"
    elsif self.aasm_state == "order_cancell_appled"
      "订单取消申请"
    elsif self.aasm_state == "order_cancelled"
      "订单已取消"
    elsif self.aasm_state == "good_returned_appled"
      "退货申请"
    elsif self.aasm_state == "good_returned"
      "已退货"
    else
      "未支付"
    end
  end


    def pay_status
      if self.is_paid
        "已支付"
      else
        "未支付"
      end
    end

  include AASM

  aasm do
    state :order_placed, initial: true
    state :paid
    state :shipping
    state :shiped
    state :order_cancelled
    state :good_returned
    state :order_cancell_appled



    #已支付
    event :make_payment do
      transitions from: :order_placed, to: :paid
    end

    #出货
    event :ship do
      transitions from: :paid,         to: :shipping
    end

    #到货
    event :deliver do
      transitions from: :shipping,      to: :shipped
    end

      #未取消订单
    event :appl_cancell_order do
      transitions from: [:order_placed, :paid], to: :order_cancelled
    end

    #申请退货
    event :return_good do
      transitions from: :shipped,       to: :good_returned
    end

    #退货
    event :cancell_order do
      transitions from: [:order_placed, :paid], to: :order_cancell_appled
    end


  end

end
