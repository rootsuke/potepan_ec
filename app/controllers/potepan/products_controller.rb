class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @properties = @product.product_properties.includes(:property)
    @shipping_methods = @product.shipping_category.shipping_methods
  end
end
