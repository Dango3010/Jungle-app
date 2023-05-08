class Admin::ProductsController < ApplicationController
  # before_action :authenticate

  http_basic_authenticate_with :name => ENV['BASIC_AUTH_USERNAME'], :password => ENV['BASIC_AUTH_PASS']

  def index
    @products = Product.order(id: :desc).all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to [:admin, :products], notice: 'Product created!'
    else
      render :new
    end
  end

  def destroy
    @product = Product.find params[:id]
    @product.destroy
    redirect_to [:admin, :products], notice: 'Product deleted!'
  end

  private

  # def authenticate
  #   authenticate_or_request_with_http_basic("Only Admin is allowed to access") do |username, password|
  #     username == ENV['BASIC_AUTH_USERNAME'] && password == ENV['BASIC_AUTH_PASS']
  #   end
  # end

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :category_id,
      :quantity,
      :image,
      :price
    )
  end

end
