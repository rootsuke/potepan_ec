Spree::Product.class_eval do
  NUMBER_OF_RELATED_PRODUCTS = 4

  def related_products_ids
    Spree::Product.joins(:classifications).where(spree_products_taxons: { taxon_id: taxons }).
      where.not(id: id).distinct.pluck(:id).sample(NUMBER_OF_RELATED_PRODUCTS)
  end

  scope :related_products_of, -> (product) do
    includes(master: [:images, :default_price]).where(id: product.related_products_ids)
  end
end