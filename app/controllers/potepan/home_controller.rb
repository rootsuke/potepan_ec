class Potepan::HomeController < ApplicationController
  def index
    @available_products = Spree::Product.includes(master: [:images, :default_price]).available
  end
end
