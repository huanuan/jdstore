module CartsHelper
  def render_cart_total_price(cart)
    sum = 0
    cart.cart_items.each do |cart_item|
      sum +=cart_item.quantity * cart_item.product.price
    end
    sum
  end

  def total_price
    sum = 0
    cart_items.each do |cart_item|
      sum += cart_item.quantity * cart_item.product.price
    end
    sum
  end
end
