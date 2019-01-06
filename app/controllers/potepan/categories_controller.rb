class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.includes(root: :children)
    @products = Spree::Product.in_taxon(@taxon).includes_images_and_price.filter_by_option(params[:option_value])
    if params[:option_type] == "color"
      @variants = Spree::Variant.fetch_variants_of(@products.pluck(:id), params[:option_value])
    end
    @view_type = params[:view_type] == "list" ? "list" : "grid"
  end
end
