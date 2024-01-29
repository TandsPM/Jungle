require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.create(name: 'Example Name')
      @product = Product.new(
        name: 'Example',
        description: 'Example desc.',
        quantity: 10,
        price_cents: 1000,
        category: @category
      )
    end

    it 'successfully saves with all fields' do
      @product.save
      puts @product.errors.full_messages
      expect(@product.save).to be true
    end
    
    it 'is not valid without a name' do
      @product.name = nil
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'is not valid without a quantity amount' do
      @product.quantity = nil
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'is not valid without a category' do
      @product.category = nil
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
