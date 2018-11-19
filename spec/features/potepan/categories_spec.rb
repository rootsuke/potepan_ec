require 'rails_helper'

RSpec.feature "Visiting Category Page", type: :feature do
  let(:taxonomy)       { create(:taxonomy, name: "Category") }
  let(:taxon_clothing) { create(:taxon,    name: "Clothing", parent: taxonomy.root,  taxonomy: taxonomy) }
  let(:taxon_shirts)   { create(:taxon,    name: "Shirts",   parent: taxon_clothing, taxonomy: taxonomy) }
  let(:taxon_jacket)   { create(:taxon,    name: "Jacket",   parent: taxon_clothing, taxonomy: taxonomy) }
  let(:taxons)         { [taxonomy.root, taxon_clothing, taxon_shirts, taxon_jacket] }
  let!(:rails_shirts)  { create(:product,  name: "Rails Shirts", taxons: [taxon_shirts]) }
  let!(:java_shirts)   { create(:product,  name: "Java Shirts",  taxons: [taxon_shirts]) }
  let!(:php_jacket)    { create(:product,  name: "PHP Jacket",   taxons: [taxon_jacket]) }
  let(:products)       { [rails_shirts, java_shirts, php_jacket] }

  background do
    visit potepan_category_path(taxon_clothing.id)
  end

  scenario "render show_page" do
    # save_and_open_page
    expect(current_path).to eq potepan_category_path(taxon_clothing.id)
    expect(page).to have_title "#{taxon_clothing.name} | BIGBAG Store"
    # カテゴリーツリーがすべて表示されているか
    within "#categories_tree" do
      taxons.each do |taxon|
        expect(page).to have_content taxon.name
      end
    end
    # デフォルトではgridボタンのクラスにactiveがついているか
    within "#switching_view_btn" do
      expect(page).to have_selector "a.active", text: "Grid"
    end
    within "#light_section_top" do
      click_link "Home"
    end
    expect(page).to have_title "BIGBAG Store"
    expect(current_path).to eq potepan_index_path
  end

  context "List view" do
    # jsを使ったテストはfont-awesomeがブラウザで読み込めずエラーが起こる
    scenario "rendering by list_view" do
      click_link "List"
      within "#list_view" do
        products.each do |product|
          expect(page).to have_content product.name
        end
      end
    end
  end

  feature "Products category" do
    context "Clothing" do
      scenario "seeing in page" do
        # clothingカテゴリー全ての商品が表示されているか
        within "#grid_view" do
          products.each do |product|
            expect(page).to have_content product.name
          end
        end
      end
    end

    context "Shirts" do
      scenario "seeing in page" do
        within "#categories_tree" do
          click_link "Shirts"
        end
        # shirtsカテゴリーの商品だけ表示されているか
        within "#grid_view" do
          expect(page).to have_content rails_shirts.name
          expect(page).to have_content java_shirts.name
        end
      end
    end
  end
end
