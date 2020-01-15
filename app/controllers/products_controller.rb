class ProductsController < ApplicationController
  # before_action :set_product, except: [:index, :new, :create]

  def index
    @products = Product.order("created_at DESC")
    @images =Image.all
    @products = Product.includes(:images).order('created_at DESC')
  end

  def new
    @product = Product.new
    @product.images.new

  # ---------------------------------------------------
  #セレクトボックスの初期値設定
  @category_parent_array = ["---"]
  #データベースから、親カテゴリーのみ抽出し、配列化
        Category.where(ancestry: nil).each do |parent|
           @category_parent_array << parent.name
        end
     end
  
     # 以下全て、formatはjsonのみ
     # 親カテゴリーが選択された後に動くアクション
     def get_category_children
        #選択された親カテゴリーに紐付く子カテゴリーの配列を取得

        @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
     end
  
     # 子カテゴリーが選択された後に動くアクション
     def get_category_grandchildren
  #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
        @category_grandchildren = Category.find("#{params[:child_id]}").children
     end
  # ーーーーーーーーーーーーーーーー

  def create
    @product = Product.new(product_params)
    if @product.save
    redirect_to root_path 
    else
      render :new
    end
  end



def product_params
  params.require(:product).permit(
    :name, :description, :condition, :shipping_fee, :shipping_how, :shipping_from, :shipping_date, :price, :likes_count, :user_id, :customer_id,  :category_id, :size, :brand, images_attributes: [ :image]) 
end

def edit
end

def update
  if @product.update(product_params)
    redirect_to root_path
  else
    render :edit
  end
end



# def set_product
#   @product = Product.find(params[:id])
# end


  def destroy
    @product.destroy
    redirect_to root_path
  end



  def show
  end  



def search
  respond_to do |format|
    format.html
    format.json do
     @children = Category.find(params[:parent_id]).children
     #親ボックスのidから子ボックスのidの配列を作成してインスタンス変数で定義
    end
  end
end
end