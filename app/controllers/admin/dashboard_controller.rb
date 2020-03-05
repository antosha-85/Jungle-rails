class Admin::DashboardController < ApplicationController
  def show
    @products = Product.count 
    @categories_all = Category.count
  end
end
