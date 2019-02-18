class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.includes(root: :children)
    @products = Spree::Product.in_taxon(@taxon).includes_images_and_price.filter_by_option(params[:option_value]).sort_by_option(params[:sort])
    if params[:option_type] == "color"
      @variants = Spree::Variant.fetch_variants_of(@products.pluck(:id), params[:option_value])
    end
    @view_type = params[:view_type] == "list" ? "list" : "grid"
    @sizes = Spree::OptionType.fetch_option_values("Size")
    @colors = Spree::OptionType.fetch_option_values("Color")
    @the_number_of_products_in_option = Spree::Variant.count_products(@products.pluck(:id))
  end
end
