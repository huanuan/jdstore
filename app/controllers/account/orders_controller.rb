class Account::OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    # @orders = Order.where(user: current_user)
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
    @order = Order.find_by_token(params[:id])
    #render :text => params[:token]
    #flash[:notice] = @order.billing_name
    #flash[:notice] = @order.id
    @product_lists = @order.product_lists

  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to  :back
  end

  def appl_cancell_order
    @order = Order.find(params[:id])
    @order.appl_cancell_order!

    flash[:notice] = "订单已取消"
    redirect_to account_orders_path
  end


  def appl_return_good
    @order = Order.find(params[:id])
    @order.appl_good_returned!

    flash[:notice] = "退货申请中"
    redirect_to account_orders_path
  end

  def refund
    @order = Order.find(params[:id])
    @order.refund!

    flash[:notice] = "退款成功!"
    redirect_to admin_orders_path
  end

end
