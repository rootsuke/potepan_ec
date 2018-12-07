require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  describe "GET #show" do
    let(:taxonomy) { create(:taxonomy, name: "Category") }
    let(:taxon_clothing) { create(:taxon, name: "Clothing", taxonomy: taxonomy, parent: taxonomy.root) }
    let(:taxon_t_shirt) { create(:taxon, name: "T-Shirts", taxonomy: taxonomy, parent: taxon_clothing) }
    let(:taxon_mag) { create(:taxon, name: "Mag", taxonomy: taxonomy, parent: taxonomy.root) }

    let!(:product_t_shirt) { create(:product, name: "Rails T-Shirts", taxons: [taxon_t_shirt]) }
    let!(:product_mag) { create(:product, name: "Rails Mag", taxons: [taxon_mag]) }

    before do
      get :show, params: { id: taxon_clothing.id }
    end

    it "returns http success" do
      expect(response).to have_http_status :success
    end

    it "returns 200 response" do
      expect(response).to have_http_status "200"
    end

    it "assigns @taxon" do
      expect(assigns(:taxon)).to eq taxon_clothing
    end

    it "assigns @taxonomies" do
      expect(assigns(:taxonomies)).to eq [taxonomy]
    end

    it "render show_page" do
      expect(response).to render_template :show
    end

    describe "products" do
      it "include product in the category" do
        expect(assigns(:products)).to contain_exactly product_t_shirt
      end

      it "don't include product out of the category" do
        expect(assigns(:products)).not_to contain_exactly product_mag
      end
    end
  end
end
