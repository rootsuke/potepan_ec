require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe "#show" do
    let(:product) { FactoryBot.create(:product) }

    it "responds successfully" do
      get :show, params: { id: product.id }
      expect(response).to be_successful
    end
  end
end
