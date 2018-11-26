class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @properties = @product.product_properties.includes(:property)
    @shipping_methods = @product.shipping_category.shipping_methods
    @related_products = Spree::Product.related_products_of(@product).limit(4)
  end
end
