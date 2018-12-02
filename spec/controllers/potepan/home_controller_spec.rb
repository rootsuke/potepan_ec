require 'rails_helper'

RSpec.describe Potepan::HomeController, type: :controller do
  let!(:product_oldest)      { create(:product, available_on: 2.days.ago) }
  let!(:product_old)         { create(:product, available_on: 1.day.ago) }
  let!(:product_new)         { create(:product, available_on: DateTime.now) }
  let!(:not_arrival_product) { create(:product, available_on: 2.days.since) }

  describe "#index" do
    before do
      get :index
    end

    it "responds successfully" do
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      expect(response).to have_http_status "200"
    end

    it "render index_page" do
      expect(response).to render_template :index
    end

    describe "new_arrival_products" do
      it "assigns @new_arrival_products" do
        expect(assigns(:new_arrival_products)).to eq [product_new, product_old, product_oldest]
      end

      it "don't include not_arrival_product" do
        expect(assigns(:new_arrival_products)).not_to contain_exactly not_arrival_product
      end
    end
  end
end
