require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  describe "GET #show" do
    let(:taxon) { create(:taxon) }

    before do
      get :show, params: { id: taxon.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns 200 response" do
      expect(response).to have_http_status "200"
    end

    it "assigns @taxon" do
      expect(assigns(:taxon)).to eq taxon
    end

    it "render show_page" do
      expect(response).to render_template "potepan/categories/show"
    end
  end
end
