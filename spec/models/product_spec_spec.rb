require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:all) do
      @category = Category.new(name: "name")
      @product = Product.new(name: "name", price: 1, quantity: 1, category: @category)
    end
    it "validates works" do
      expect(@product).to be_valid
      expect(@product.errors).to be_empty
    end
    it "validates name" do
      @name = Product.new(name: nil, price: 1, quantity: 1, category: @category)
      expect(@name).to_not be_valid
      expect(@name.errors.full_messages).to include("Name can't be blank")
    end
    it "validates price" do
      @price = Product.new(name: "name", price: nil, quantity: 1, category: @category)
      expect(@price).to_not be_valid
      expect(@price.errors.full_messages).to include("Price is not a number")
    end
    it "validates quantity" do
      @quantity = Product.new(name: "name", price: 1, quantity: nil, category: @category)
      expect(@quantity).to_not be_valid
      expect(@quantity.errors.full_messages).to include("Quantity can't be blank")
    end
    it "validates category" do
      @category = Product.new(name: "name", price: 1, quantity: 1, category: nil)
      expect(@category).to_not be_valid
      expect(@category.errors.full_messages).to include("Category can't be blank")
    end
  end
end