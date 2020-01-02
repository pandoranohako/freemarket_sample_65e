class ProductsController < ApplicationController

  def index
    @products = Product.order("id DESC")
    @images =Image.all
  end

end
