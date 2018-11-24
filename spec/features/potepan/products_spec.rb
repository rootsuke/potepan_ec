require 'rails_helper'

RSpec.feature "Visiting Product Page", type: :feature do
  given(:product)           { create(:product) }
  given(:property)          { create(:property) }
  given!(:product_property) { create(:product_property, value: "red", product: product, property: property) }
  given!(:shipping_method)  { create(:shipping_method) }
  given!(:taxonomy)         { create(:taxonomy, name: "Category") }

  scenario "render show_page and index_page" do
    visit potepan_product_path product.id
    expect(page).to have_content product.name
    expect(page).to have_content product.description
    expect(page).to have_content product.display_price
    expect(page).to have_content property.name
    expect(page).to have_content product_property.value
    expect(page).to have_content shipping_method.name
    expect(page).to have_title "#{product.name} | BIGBAG Store"
    expect(current_path).to eq potepan_product_path(product.id)
    within ".lightSection" do
      click_link "Home"
    end
    expect(page).to have_title "BIGBAG Store"
    expect(current_path).to eq potepan_index_path
  end
end
