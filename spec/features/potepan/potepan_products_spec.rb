require 'rails_helper'

RSpec.feature "Potepan::Products", type: :feature do
  given(:product) { create(:product) }

  scenario "render index_page" do
    visit potepan_root_path
    click_link 'Home'
    expect(page).to have_title("BIGBAG Store")
    expect(current_path).to eq(potepan_index_path)
  end

  scenario "render show_page" do
    visit potepan_product_path(product.id)
    expect(page).to have_content(product.name)
    expect(page).to have_content(product.description)
    expect(page).to have_content(product.display_price)
    expect(page).to have_title("#{product.name} | BIGBAG Store")
    expect(current_path).to eq potepan_product_path(product.id)
  end
end
