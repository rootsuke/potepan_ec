require 'rails_helper'

RSpec.feature "Visiting Category Page", type: :feature do
  let!(:taxonomy) { create(:taxonomy, name: "Category") }
  let(:taxon_clothing) { create(:taxon, name: "Clothing", parent: taxonomy.root, taxonomy: taxonomy) }
  let(:taxon_shirt) { create(:taxon, name: "Shirts", parent: taxon_clothing, taxonomy: taxonomy) }
  let(:taxon_jacket) { create(:taxon, name: "Jackets", parent: taxon_clothing, taxonomy: taxonomy) }
  let(:taxons) { [taxonomy.root, taxon_clothing, taxon_shirt, taxon_jacket] }

  let!(:rails_shirt) { create(:product, name: "Rails Shirt", taxons: [taxon_shirt]) }
  let!(:java_shirt) { create(:product, name: "Java Shirt", taxons: [taxon_shirt]) }
  let!(:php_jacket) { create(:product, name: "PHP Jacket", taxons: [taxon_jacket]) }
  let(:products) { [rails_shirt, java_shirt, php_jacket] }

  background do
    visit potepan_category_path taxonomy.root.id
  end

  scenario "render show_page" do
    within "#link_to_grid_view" do
      click_link "All Categories"
    end
    expect(current_path).to eq potepan_category_path(taxonomy.root.id)
    expect(page).to have_title "#{taxonomy.root.name} | BIGBAG Store"
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
    within "#link_to_list_view" do
      click_link "All Categories"
    end
    within "#switching_view_btn" do
      expect(page).to have_selector "a.active", text: "List"
    end
    within "#light_section_top" do
      click_link "Home"
    end
    expect(page).to have_title "BIGBAG Store"
    expect(current_path).to eq potepan_index_path
  end

  # jsを使ったテストはfont-awesomeがブラウザで読み込めずエラーが起こるためHTMLのテストのみ
  scenario "switch view_type by Switching_view_btn" do
    click_link "List"
    within "#switching_view_btn" do
      expect(page).to have_selector "a.active", text: "List"
    end
    within "#list_view" do
      products.each do |product|
        expect(page).to have_content product.name
      end
    end
    click_link "Grid"
    within "#switching_view_btn" do
      expect(page).to have_selector "a.active", text: "Grid"
    end
  end

  feature "Products" do
    context "All categories" do
      scenario "seeing in page" do
        # 全ての商品が表示されているか
        within "#grid_view" do
          products.each do |product|
            expect(page).to have_content product.name
          end
        end
      end
    end

    context "Shirts category" do
      scenario "seeing in page" do
        within "#categories_tree" do
          click_link "Shirts"
        end
        # shirtsカテゴリーの商品だけ表示されているか
        within "#grid_view" do
          expect(page).to have_content rails_shirt.name
          expect(page).to have_content java_shirt.name
          expect(page).not_to have_content php_jacket.name
        end
      end
    end
  end
end
