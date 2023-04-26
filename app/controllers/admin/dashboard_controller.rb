class Admin::DashboardController < ApplicationController
  def show
    @categories = Category.order(id: :desc).all
    @count = Category.count
    @count2 = Product.count
  end
end
