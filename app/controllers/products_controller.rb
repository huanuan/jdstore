class ProductsController < ApplicationController
   before_filter :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
     @product = Product.new(product_params)

   if @product.save
      redirect_to products_path
   else
     render :new
   end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to products_path
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])

    @product.destroy

    redirect_to products_path
  end

  def add_to_cart
    @product = Product.find(params[:id])
    if @product.quantity > 0
      @cart_item = CartItem.find_by(product_id: @product.id,cart_id: current_cart.id)

      if @cart_item
        flash[:alert] = "此商品已在购物车!"
      else
      current_cart.add_product_to_cart(@product)
      flash[:notice] = "成功加入购物车！"
      end
      # @cart_item = CartItem.find_by(product_id: @product.id,cart_id: current_cart.id)
      #
      # if @cart_item
      #   flash[:alert] = "不能重复加入购物车哦"
      # else
      #   current_cart.add_product_to_cart(@product)
      #   flash[:notice] =  "加入购物车成功"
      # end
    else
      flash[:alert] = "商品缺货!"
    end
    redirect_to :back
  end

 private

 def product_params
   params.require(:product).permit(:title, :price, :description, :image, :contact_email)
 end

end
