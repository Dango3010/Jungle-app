class Admin::DashboardController < ApplicationController
  def show
    @categories = Category.order(id: :desc).all
    products = Product.order(id: :desc).all
    @count = @categories.length
    @count2 = products.length
  end
end
