require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe "#show" do
    let(:product) { create(:product) }
    let(:property) { create(:property) }
    let!(:product_property) { create(:product_property, value: "red", product: product, property: property) }
    let!(:shipping_method) { create(:shipping_method) }

    before do
      get :show, params: { id: product.id }
    end

    it "responds successfully" do
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      expect(response).to have_http_status "200"
    end

    it "assigns @product" do
      expect(assigns(:product)).to eq product
    end

    it "assigns @product_properties" do
      expect(assigns(:properties)).to contain_exactly product_property
    end

    it "assigns @shipping_methods" do
      expect(assigns(:shipping_methods)).to contain_exactly shipping_method
    end

    it "render show page" do
      expect(response).to render_template :show
    end
  end
end
