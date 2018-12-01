Spree::Product.class_eval do
  scope :related_products_of, -> (product) do
    joins(:classifications).includes(master: [:images, :default_price]).
      where(spree_products_taxons: { taxon_id: product.taxons }).
      where.not(id: product.id).order(Arel.sql("RAND()")).distinct
  end
end
