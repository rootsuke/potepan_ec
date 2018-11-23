class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @properties = @product.product_properties.includes(:property)
    @shipping_methods = @product.shipping_category.shipping_methods
    # TODO @productを@related_productsに含めないようにする
    @related_products = Spree::Product.includes(:classifications, master: [:images, :default_price]).where("spree_products_taxons.taxon_id": @product.taxons).limit(4)
  end
end
