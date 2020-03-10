require 'rails_helper'

RSpec.feature "Visitor navigates from home page to the product detail page", type: :feature, js: true do

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

  scenario "They can visit product page" do
    # ACT
    visit root_path
    # click_on @product.name
    # page.find_link('Details »').first.click 
    click_link("Details »", :match => :first)
    visit "products/#{@product[:id]}"

    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_css 'article.product-detail'
  end
end