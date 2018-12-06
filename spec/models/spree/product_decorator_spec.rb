require 'rails_helper'

RSpec.describe Spree::Product, type: :model do
  let(:product)              { create(:product, taxons: [related_taxon]) }
  let!(:related_products)    { create_list(:product, 4, taxons: [related_taxon]) }
  let!(:not_related_product) { create(:product, taxons: [not_related_taxon]) }

  let(:taxonomy)          { create(:taxonomy) }
  let(:related_taxon)     { create(:taxon, parent: taxonomy.root, taxonomy: taxonomy) }
  let(:not_related_taxon) { create(:taxon, parent: taxonomy.root, taxonomy: taxonomy) }

  describe "Scope: related_products_of" do
    subject { Spree::Product.related_products_of(product) }

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

    describe "related_products_ids" do
      subject { product.related_products_ids }

      it { is_expected.not_to include not_related_product.id }

      it { is_expected.not_to include product.id }
    end
  end
end
