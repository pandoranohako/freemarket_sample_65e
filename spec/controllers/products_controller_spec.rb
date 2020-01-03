require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'GET #index' do
    it "populates an array of products ordered by created_at DESC" do
      products = FactoryBot.create_list(:product, 3)
      get :index
      expect(assigns(:products)).to match(products.sort{ |a, b| b.created_at <=> a.created_at } )
    end

    it "populates an array of all images" do
      images = FactoryBot.create_list(:image, 3) 
      get :index
      expect(assigns(:images)).to match(images)
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end
end
