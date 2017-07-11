require "rails_helper"

RSpec.describe CategoriesController, type: :controller do
  let!(:category){FactoryGirl.create :category}
  let!(:product){FactoryGirl.create :product}
  let!(:user){FactoryGirl.create :user}
  let!(:product2){FactoryGirl.create :product, category_id: 2}

  before :each do
    allow(controller).to receive(:current_user).and_return user
  end

  describe "GET #index" do
    it "params q equal nil" do
      get :index, params: {q: {name_cont: ""}}
      expect(assigns(:categories)).to eq [category]
      expect(assigns(:category)).to be_a_new Category
    end

    it "params term is present" do
      get :index, params: {term: category.name}, format: :json
      expect(assigns(:categories)).to eq [category]
      expect(assigns(:category)).to be_a_new Category
    end

    it "params category_id is present" do
      get :index, params: {category_id: category.id}, xhr: true
      expect(assigns(:category)).to be_a_new Category
      expect(assigns(:products)).to eq [product2]
      expect(response).to render_template ("categories/_cate_product")
    end

    it "params category_id and param[:delete] is present" do
      get :index, params: {category_id: category.id, delete: true}, xhr: true
      expect(assigns(:category)).to be_a_new Category
      expect(assigns(:products)).to eq [product]
      expect(response).to render_template ("categories/_cate_product")
    end

    it "params product_name and product_ids is present" do
      get :index, params: {product_name: product.name, product_ids: [product.id]}, xhr: true
      expect(assigns(:category)).to be_a_new Category
      expect(assigns(:products)).to eq [product]
      expect(response).to render_template ("categories/_cate_product")
    end
  end

  describe "POST #create" do
    it "Create category successfully" do
      expect do
        post :create, params: {category: {name: "New category"}}
      end.to change(Category, :count).by 1

      expect(flash[:success]).to be_present
      expect(subject).to redirect_to categories_path
    end

    it "Create category fail with same name" do
      expect do
        post :create, params: {category: {name: category.name}}
      end.to change(Category, :count).by 0

      expect(flash[:danger]).to be_present
      expect(subject).to redirect_to categories_path
    end
  end

  describe "PATCH #update" do
    it "update category successfully" do
      patch :update, params: {id: category.id, category: {name: "update category"}}, xhr: true, format: :json
      category.reload
      expect(category.name).to eq "update category"
    end
  end

  describe "DELETE #destroy" do
    it "destroy category successfully" do
      expect do
        delete :destroy, params: {id: category.id}, format: :json
      end.to change(Category, :count).by -1
      expect(subject).to respond_with 200
    end
  end
end