class ProductsController < ApplicationController

  def index
    @products = Product.order("created_at DESC")
    @images =Image.all
  end

  def new
  end

  def create
  end

  def destroy
    @product = Product.find(params[:id])
    # binding.pry
    if @product.user_id === 1   #あとでcurrent_user.idを記入する
      @product.destroy
      redirect_to root_path
      flash[:alert] = '商品を削除しました'
    else
      redirect_to root_path
      flash[:alert] = '商品削除に失敗しました'
    end
  end

  def edit
  end

  def update
  end

  def show
    @product = Product.find(params[:id])
    @image = @product.images.order("created_at DESC")
  end
end