require 'rails_helper'

RSpec.describe Spree::Product, type: :model do
  subject { Spree::Product.related_products_of(product) }

  let(:product)              { create(:product, taxons: [related_taxon]) }
  let!(:related_product)     { create(:product, taxons: [related_taxon]) }
  let!(:not_related_product) { create(:product, taxons: [not_related_taxon]) }

  let(:taxonomy)          { create(:taxonomy) }
  let(:related_taxon)     { create(:taxon, parent: taxonomy.root, taxonomy: taxonomy) }
  let(:not_related_taxon) { create(:taxon, parent: taxonomy.root, taxonomy: taxonomy) }

  it { is_expected.to contain_exactly related_product }

  it { is_expected.not_to contain_exactly not_related_product }

  it { is_expected.not_to contain_exactly product }
end
