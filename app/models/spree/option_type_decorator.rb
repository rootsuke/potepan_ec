Spree::OptionType.class_eval do
  def self.fetch_option_values(color_or_size)
    joins(:option_values).where(spree_option_types: { presentation: color_or_size }).pluck("spree_option_values.presentation")
  end
end
