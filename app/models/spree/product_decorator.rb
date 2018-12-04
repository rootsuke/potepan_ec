Spree::Product.class_eval do
  NUMBER_OF_RELATED_PRODUCTS = 4

  scope :related_products_of, -> (product) do
    related_products_ids =
      joins(:classifications).where(spree_products_taxons: { taxon_id: product.taxons }).
        where.not(id: product.id).distinct.pluck(:id).sample(NUMBER_OF_RELATED_PRODUCTS)
    includes(master: [:images, :default_price]).where(id: related_products_ids)
  end
end
