class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :destroy]

  def index
    @products = Product.order("created_at DESC")
    @images =Image.all
    @products = Product.includes(:images).order('created_at DESC')
  end

  def new
    @product = Product.new
    @product.images.new

     # 全て、formatはjsonのみ
     # 親カテゴリーが選択された後に動くアクション
     def get_category_children
        #選択された親カテゴリーに紐付く子カテゴリーの配列を取得

        @category_children = Category.find_by(id: "#{params[:parent_name]}", ancestry: nil).children
     end
  end  
     # 子カテゴリーが選択された後に動くアクション
     def get_category_grandchildren
  #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
        @category_grandchildren = Category.find("#{params[:child_id]}").children
     end
  
  def create
    @product = Product.new(product_params)
    if @product.save
        redirect_to root_path 
    else
        render :new
    end
  end

 

  def edit
    @product = Product.find(params[:id])
    def get_category_children
      #選択された親カテゴリーに紐付く子カテゴリーの配列を取得

      @category_children = Category.find_by(id: "#{params[:parent_name]}", ancestry: nil).children
   end
end  
   # 子カテゴリーが選択された後に動くアクション
   def get_category_grandchildren
#選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
      @category_grandchildren = Category.find("#{params[:child_id]}").children
   end

  def update
    if @product.update(product_update_params)
        redirect_to root_path
    else
        render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
    # 削除に成功した時の処理
      redirect_to root_path
      flash[:alert] = '商品を削除しました'
    else
    # 削除に失敗した時の処理
      redirect_to root_path
      flash[:alert] = '商品削除に失敗しました'
    end
  end

  def show
    @product = Product.find(params[:id])
    @image = @product.images.order("created_at DESC")
    @seller_name = User.find(@product.user_id)
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

  private

  def product_params
    params.require(:product).permit(
      :name, :description, :condition, :shipping_fee, :shipping_how, :shipping_from, :shipping_date, :price, :likes_count, :category_id, :size, :brand, images_attributes: [ :image]).merge( user_id: current_user.id)
  end

  def product_update_params
    params.require(:product).permit(
    :name, :description, :condition, :shipping_fee, :shipping_how, :shipping_from, :shipping_date, :price, :likes_count, :category_id, :size, :brand).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
    
  end
end