class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.includes(root: :children)
    @products = Spree::Product.in_taxon(@taxon).includes_images_and_price
    @view_type = params[:view_type] == "list" ? "list" : "grid"
  end
end
