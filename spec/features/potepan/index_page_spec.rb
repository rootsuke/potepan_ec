require 'rails_helper'

RSpec.feature "Visiting Index Page", type: :feature do
  let!(:product_oldest)      { create(:product, available_on: 2.days.ago) }
  let!(:product_old)         { create(:product, available_on: 1.day.ago) }
  let!(:product_new)         { create(:product, available_on: DateTime.now) }
  let!(:not_arrival_product) { create(:product, available_on: 2.days.since) }
  let(:new_arrival_products) { [product_oldest, product_old, product_new] }

  let!(:taxonomy) { create(:taxonomy, name: "Category") }

  background do
    visit potepan_root_path
  end

  scenario "render successfully" do
    click_link "Home"
    expect(page).to have_title "BIGBAG Store"
    expect(current_path).to eq potepan_index_path
  end

  feature "New_arrival_products" do
    scenario "seeing in page" do
      within "#new_arrival" do
        new_arrival_products.each do |new_arrival_product|
          expect(page).to have_content new_arrival_product.name
        end
        expect(page).not_to have_content not_arrival_product.name
      end
    end
  end
end
