require 'rails_helper'

RSpec.describe Potepan::HomeController, type: :controller do
  let(:product_old)           { create(:product, available_on: 2.days.ago) }
  let(:product_new)           { create(:product, available_on: DateTime.now) }
  let(:product_not_available) { create(:product, available_on: 2.days.since) }

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

    describe "available_products" do
      it "assigns @available_products" do
        expect(assigns(:available_products)).to eq [product_new, product_old]
      end

      it "not include product_not_available" do
        expect(assigns(:available_products)).not_to contain_exactly product_not_available
      end
    end
  end
end
