class Admin::DashboardController < ApplicationController
  def show
    @categories = Category.order(id: :desc).all
    @count = @categories.length
    @products = Product.order(id: :desc).all
  end
end
