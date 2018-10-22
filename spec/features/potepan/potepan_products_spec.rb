require 'rails_helper'

RSpec.feature "Potepan::Products", type: :feature do
  scenario "visit show_page" do
    product = create(:product)

    visit potepan_product_path(product.id)
    expect(page).to have_content(product.name)
    expect(page).to have_content(product.description)
    expect(page).to have_content(product.display_price)
  end
end
