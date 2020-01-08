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
    @product.destroy
    redirect_to root_path
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