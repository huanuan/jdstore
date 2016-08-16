class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def show
    @order = Order.find_by_token(params[:id])
    @product_lists = @order.product_lists
  end


  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.total = current_cart.total_price

    if @order.save
      current_cart.cart_items.each do |cart_item|
        product_list = ProductList.new
        product_list.order = @order
        product_list.product_name = cart_item.product.title
        product_list.product_price = cart_item.product.price
        product_list.quantity = cart_item.quantity
        product_list.save
      end
      redirect_to order_path(@order.token)
    else
      render 'carts/checkout'
    end
  end

  def pay_with_wechat
    payment_method = params[:payment_method]
    @order = Order.find(params[:id])

    if @order.is_paid
      flash[:alert] = "已经支付成功，无需再次支付"
      redirect_to :back
      return
    end

    @order.payment_method = payment_method
    @order.is_paid = true

    if @order.save
      flash[:notice] = "支付成功"
      redirect_to account_orders_path
    else
      flash[:notice] = "支付失败"
      redirect_to :back
    end

  end

  def pay_with_alipay
    payment_method = params[:payment_method]
    @order = Order.find(params[:id])

    if @order.is_paid
      flash[:alert] = "已经支付成功，无需再次支付"
      redirect_to :back
      return
    end

    @order.payment_method = payment_method
    @order.is_paid = true

    if @order.save
      flash[:notice] = "支付成功"
      redirect_to account_orders_path
    else
      flash[:notice] = "支付失败"
      redirect_to :back
    end

  end

  private

  def order_params
    params.require(:order).permit(:billing_name, :billing_address, :shopping_name, :shopping_address, :create)
  end
end
