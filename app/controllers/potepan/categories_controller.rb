class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.includes(root: :children)
    @products = @taxon.products.all.includes(master: :images)
  end
end
