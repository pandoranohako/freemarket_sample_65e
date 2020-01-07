class ProductsController < ApplicationController

  def index
    @products = Product.order("created_at DESC")
    @images =Image.all
    @products = Product.includes(:images).order('created_at DESC')
  end

  def new
    @product = Product.new
    @product.images.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
    redirect_to root_path 
    else
      render :new
  end
end

private

def product_params
  params.require(:product).permit(
    :name, :description, :condition, :shipping_fee, :shipping_how, :shipping_from, :shipping_date, :price, :likes_count, :user, :customer,  :category, :size, :brand, images_attributes: [:image]) 
end


  def destroy
  end

  def new
  end

  def show
  end  
end
