require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe "#show" do
    let(:product) { create(:product, taxons: [related_taxon]) }
    let(:property) { create(:property) }
    let!(:product_property) { create(:product_property, value: "red", product: product, property: property) }
    let!(:shipping_method) { create(:shipping_method) }
    let!(:related_products) { create_list(:product, 4, taxons: [related_taxon]) }
    let!(:not_related_product) { create(:product, taxons: [not_related_taxon]) }

    let(:taxonomy) { create(:taxonomy) }
    let(:related_taxon) { create(:taxon, parent: taxonomy.root, taxonomy: taxonomy) }
    let(:not_related_taxon) { create(:taxon, parent: taxonomy.root, taxonomy: taxonomy) }

    before do
      get :show, params: { id: product.id }
    end

    it "responds successfully" do
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      expect(response).to have_http_status "200"
    end

    it "render show page" do
      expect(response).to render_template :show
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

    describe "Related_products" do
      it "does not include not_related_product" do
        expect(assigns(:related_products)).not_to include not_related_product
      end

      context "related_taxon has 4 products" do
        it "assigns @related_products" do
          expect(assigns(:related_products)).to match_array related_products
        end

        it "the number of related_products is 4" do
          expect(assigns(:related_products).count).to eq 4
        end
      end

      context "related_taxon has 5 products" do
        let!(:related_products_5) { create(:product, taxons: [related_taxon]) }

        it "the number of related_products is 4" do
          expect(assigns(:related_products).count).to eq 4
        end
      end
    end
  end
end
