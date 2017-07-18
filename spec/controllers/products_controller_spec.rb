require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  let!(:product){FactoryGirl.create :product}
  let!(:category){FactoryGirl.create :category}
  let!(:user){FactoryGirl.create :user}

  before :each do
    allow(controller).to receive(:current_user).and_return user
  end

  describe "GET #index" do
    it do
      get :index, params: {term: ""}
      expect(assigns(:products)).to eq [product]
      expect(assigns(:categories)).to eq [category]
    end
  end

  describe "GET #show" do
    it do
      get :show, params: {id: product.id}
      expect(assigns(:product)).to eq product
      expect(subject).to respond_with 200
      expect(subject).to render_template :show
    end
  end

  describe "GET #edit" do
    it do
      get :edit, params: {id: product.id}
      expect(assigns(:product)).to eq product
      expect(subject).to respond_with 200
      expect(subject).to render_template :edit
    end
  end

  describe "GET #new" do
    it do
      get :new
      expect(assigns(:product)).to be_a_new Product
      expect(subject).to respond_with 200
      expect(subject).to render_template :new
    end
  end

  describe "POST #create" do
    it "create new product successfully" do
      expect do
        post :create, params: {product: {name: "Product 1", description: "New", status: :available}}
      end.to change(Product, :count).by(1)
      expect(subject).to redirect_to products_path
    end
  end

  describe "PATCH #update" do
    it "request is xhr" do
      patch :update, params: {ids: [product.id], cate_id: category.id, id: product.id}, xhr: true, format: :json
      product.reload
      expect(assigns(:product)).to eq product
      expect(assigns(:products)).to eq [product]
      expect(assigns(:products).map(&:id)).to eq [category.id]
      expect(subject).to respond_with 200
    end

    it "request is normal form" do
      patch :update, params: {id: product.id, product: FactoryGirl.attributes_for(:product, name: "Update2")}
      product.reload
      expect(product.name).to eq "Update2"
    end
  end

  describe "DELETE #destroy" do
    it "request is xhr, remove product from category" do
      delete :destroy, params: {ids: [product.id], id: product.id}, xhr: true, format: :json
      product.reload
      expect(assigns(:product)).to eq product
      expect(assigns(:products)).to eq [product]
      expect(assigns(:products).map(&:category_id)).to include nil
      expect(subject).to respond_with 200
    end

    it "request is normal form, delete product" do
      expect do
        delete :destroy, params: {id: product.id}
      end.to change(Product, :count).by -1
      expect(subject).to redirect_to products_path
    end
  end
end