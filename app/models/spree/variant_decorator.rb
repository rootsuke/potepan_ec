Spree::Variant.class_eval do
  def self.count_products(products_ids)
    joins(:option_values).where(product_id: products_ids).group("spree_option_values.presentation").count("DISTINCT product_id")
  end

  scope :fetch_variants_of, -> (products_ids, option_value) do
    joins(:option_values).where(product_id: products_ids, spree_option_values: { presentation: option_value })
  end
end
