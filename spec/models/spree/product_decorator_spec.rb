require 'rails_helper'

RSpec.describe Spree::Product, type: :model do
  describe "scope: related_products_of" do
    subject { Spree::Product.related_products_of(product) }

    let(:product)              { create(:product, taxons: [related_taxon]) }
    let!(:related_products)    { create_list(:product, 4, taxons: [related_taxon]) }
    let!(:not_related_product) { create(:product, taxons: [not_related_taxon]) }

    let(:taxonomy)          { create(:taxonomy) }
    let(:related_taxon)     { create(:taxon, parent: taxonomy.root, taxonomy: taxonomy) }
    let(:not_related_taxon) { create(:taxon, parent: taxonomy.root, taxonomy: taxonomy) }

    it { is_expected.not_to include not_related_product }

    it { is_expected.not_to include product }

    context "related_taxon has 4 products" do
      it { is_expected.to match_array related_products }

      it "the number of related_products is 4" do
        expect(subject.count).to eq 4
      end
    end

    context "related_taxon has 5 products" do
      let!(:related_products_5) { create(:product, taxons: [related_taxon]) }

      it "the number of related_products is 4" do
        expect(subject.count).to eq 4
      end
    end
  end

  describe "scope: new_arrival" do
    subject { Spree::Product.new_arrival }

    let(:product_oldest)       { create(:product, available_on: 2.days.ago) }
    let(:product_old)          { create(:product, available_on: 1.day.ago) }
    let(:product_new)          { create(:product, available_on: DateTime.now) }
    let!(:not_arrival_product) { create(:product, available_on: 2.days.since) }

    it { is_expected.to eq [product_new, product_old, product_oldest] }

    it { is_expected.not_to contain_exactly not_arrival_product }
  end

  describe "scope: includes_images_and_price" do
    subject { Spree::Product.includes(master: [:images, :default_price]).to_sql }

    let(:model) { Spree::Product.includes_images_and_price.to_sql }

    it { is_expected.to eq model }
  end
end
