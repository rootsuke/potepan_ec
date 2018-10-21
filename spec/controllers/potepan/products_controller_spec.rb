require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe "#show" do
    let(:product) { create(:product) }

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

    it "render show page" do
      expect(response).to render_template "potepan/products/show"
    end
  end
end
