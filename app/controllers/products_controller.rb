class ProductsController < ApplicationController

  def index
    @products = Product.order("created_at DESC")
    @images =Image.all
  end

  def show
  end  
end
