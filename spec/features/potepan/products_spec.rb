require 'rails_helper'

RSpec.feature "Visiting Product Page", type: :feature do
  given(:product)              { create(:product,         taxons: [related_taxon]) }
  given!(:related_products)    { create_list(:product, 4, taxons: [related_taxon]) }
  given!(:related_product_5)   { create(:product,         taxons: [related_taxon]) }
  given!(:not_related_product) { create(:product,         taxons: [not_related_taxon]) }
  given(:property)             { create(:property) }
  given!(:product_property)    { create(:product_property, value: "red", product: product, property: property) }
  given!(:shipping_method)     { create(:shipping_method) }

  given!(:taxonomy)         { create(:taxonomy) }
  given(:related_taxon)     { create(:taxon, parent: taxonomy.root, taxonomy: taxonomy) }
  given(:not_related_taxon) { create(:taxon, parent: taxonomy.root, taxonomy: taxonomy) }

  scenario "render show_page and index_page" do
    visit potepan_product_path product.id
    expect(current_path).to eq potepan_product_path(product.id)
    expect(page).to have_title "#{product.name} | BIGBAG Store"
    within ".singleProduct" do
      expect(page).to have_content product.name
      expect(page).to have_content product.description
      expect(page).to have_content product.display_price
      expect(page).to have_content property.name
      expect(page).to have_content product_property.value
      expect(page).to have_content shipping_method.name
    end
    within ".lightSection" do
      click_link "Home"
    end
    expect(page).to have_title "BIGBAG Store"
    expect(current_path).to eq potepan_index_path
  end

  scenario "seeing related_products" do
    visit potepan_product_path product.id
    # 同じカテゴリーの関連商品が４つだけ表示されているか
    within ".productsContent" do
      related_products.each do |related_product|
        expect(page).to have_content related_product.name
      end
      expect(page).not_to have_content related_product_5.name
      expect(page).not_to have_content not_related_product.name
      expect(page).not_to have_content product.name
    end
  end
end
