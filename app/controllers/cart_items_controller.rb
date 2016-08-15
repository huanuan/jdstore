class CartItemsController < ApplicationController
  before_filter :authenticate_user!, only: [:add_item, :des_item, :destroy]
  def add_item
    @cart_item = current_cart.cart_items.find(params[:id])
    @cart_item.quantity = @cart_item.quantity + 1
    @cart_item.save
    redirect_to :back
  end

  def des_item
    @cart_item = current_cart.cart_items.find(params[:id])
    @cart_item.quantity = @cart_item.quantity - 1
    @cart_item.save
    redirect_to :back
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy

    redirect_to :back
  end

  def clear
    @cart = current_cart

    @cart.cart_items.destroy_all
    # @cart.cart_items.each do |cart_item|
    #  cart_item.destroy
    #end

     redirect_to :back
  end

end
