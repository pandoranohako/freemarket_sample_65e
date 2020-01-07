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
  end

  def edit
  end

  def update
  end

  def show
    @product = Product.find(params[:id])
    @image = @product.images.where(product_id: @product.id)
    # binding.pry

  end  

end
