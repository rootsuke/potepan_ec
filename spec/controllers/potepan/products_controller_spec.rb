require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe "#show" do
    let(:product)           { create(:product, taxons: [taxon]) }
    let(:property)          { create(:property) }
    let!(:product_property) { create(:product_property, value: "red", product: product, property: property) }
    let!(:shipping_method)  { create(:shipping_method) }
    let(:related_products)  { create_list(:product, 4, taxons: [taxon]) }
    let(:taxon)             { create(:taxon) }

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
      expect(assigns(:properties)).to eq [product_property]
    end

    it "assigns @shipping_methods" do
      expect(assigns(:shipping_methods)).to eq [shipping_method]
    end

    it "assigns @related_products" do
      expect(assigns(:related_products)).to eq related_products
    end

    it "render show page" do
      expect(response).to render_template :show
    end
  end
end
