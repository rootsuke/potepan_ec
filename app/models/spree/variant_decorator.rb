Spree::Variant.class_eval do
  scope :fetch_variants_of, -> (products_ids, option_value) do
    joins(:option_values).where(product_id: products_ids, spree_option_values: { presentation: option_value }).group(:product_id)
  end
end
