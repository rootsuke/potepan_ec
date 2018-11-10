class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.includes(root: :children)
    @products = Spree::Product.in_taxon(@taxon).includes(master: [:images, :default_price])
    @view_type = params[:view_type] ||= "grid"
  end
end
