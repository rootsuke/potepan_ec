require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  describe "GET #show" do
    let(:taxonomy) { create(:taxonomy, name: "Category") }
    let(:taxon)    { create(:taxon,    name: "Clothing", taxonomy: taxonomy, parent: taxonomy.root) }
    let(:taxon_child) { create(:taxon, name: "T-Shirts", taxonomy: taxonomy, parent: taxon) }
    let!(:product) { create(:product, name: "Rails T-Shirts", taxons: [taxon_child]) }

    before do
      get :show, params: { id: taxon.id }
    end

    it "returns http success" do
      expect(response).to have_http_status :success
    end

    it "returns 200 response" do
      expect(response).to have_http_status "200"
    end

    it "assigns @taxon" do
      expect(assigns(:taxon)).to eq taxon
    end

    it "assigns @taxonomies" do
      expect(assigns(:taxonomies)).to eq [taxonomy]
    end

    it "assigns @products" do
      expect(assigns(:products)).to eq [product]
    end

    it "render show_page" do
      expect(response).to render_template :show
    end
  end
end
