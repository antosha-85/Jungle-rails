require 'rails_helper'

RSpec.feature "Visitor clicks the Add to Cart button for a product and their cart increases by one", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @product = @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They can click the Add to Cart button" do
    # ACT
    visit root_path
    expect(page).to have_link("My Cart (0)")
    save_screenshot
    click_button("Add", :match => :first)
    expect(page).to have_link('My Cart (1)')
    save_screenshot
    puts page.html

  end
end