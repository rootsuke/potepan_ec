require 'rails_helper'

RSpec.feature "Potepan::Products", type: :feature do
  given(:product) { create(:product) }
  given(:property) { create(:property) }
  given!(:product_property) { create(:product_property, value: "red", product: product, property: property) }
  given!(:shipping_method) { create(:shipping_method) }

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
    # productとproduct_propetyの関連付けはmodel_specにて検証済
    expect(page).to have_content(product_property.value)
    # productとshipping_methodの関連付けはmodel_specにて検証済
    expect(page).to have_content(shipping_method.name)
    expect(page).to have_title("#{product.name} | BIGBAG Store")
    expect(current_path).to eq potepan_product_path(product.id)
  end
end
