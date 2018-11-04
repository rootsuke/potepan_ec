require 'rails_helper'

RSpec.describe Spree::Product, type: :model do
  let(:product) { create(:product) }
  let(:property) { create(:property) }
  let(:product_property) { create(:product_property, value: "red", product: product, property: property) }
  let(:shipping_method) { create(:shipping_method) }

  describe Spree::Product do
    it "has relation with product_properties" do
      # product_propertyのvalueの値がproductとの関連付けを通して一致しているか検証
      expect(product_property.value).to eq product.product_properties[0].value
    end

    it "has relation with shipping_method" do
      # shipping_methodのnameの値がproductとの関連付けを通して一致しているか検証
      expect(shipping_method.name).to eq product.shipping_category.shipping_methods[0].name
    end
  end
end
