class ProductsController < ApplicationController

  def index
    @products = Product.order("created_at DESC")
    @images =Image.all
  end

  def new
  end

  def show
    @product = Product.find(params[:id])
  end

end
