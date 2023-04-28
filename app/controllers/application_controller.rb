# puts 'propppp' + Rails.env.production?

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception. For APIs, you may want to use :null_session instead.
  
  protect_from_forgery with: :exception

  private

  def cart
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end
  helper_method :cart

  def enhanced_cart
    @enhanced_cart ||= Product.where(id: cart.keys).map {|product| { product:product, quantity: cart[product.id.to_s] } }
  end
  helper_method :enhanced_cart

  def cart_subtotal_cents
    enhanced_cart.map {|entry| entry[:product].price_cents * entry[:quantity]}.sum
  end
  helper_method :cart_subtotal_cents


  def update_cart(new_cart)
    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
    cookies[:cart]
  end

  # Prevent CSRF attacks by raising an exception. For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user #look up the user, if they're logged in, and save their user object to a variable called @current_user. 
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user #The helper_method allows us to use @current_user in our view files.

  def authorize #send someone to the login page if they aren't logged in - this is how we keep certain pages our site secure... users have to login before seeing them.
    redirect_to '/login' unless current_user
  end
end

=begin
* User authentication:
  Add a 'before_filter' to any controller that you want to secure. This will force users to login before they can see the actions in this controller. 
e.g.
class GifController < ApplicationController

  before_filter :authorize

  def cool
  end

  def free
  end

end
=end

