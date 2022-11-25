class HomeController < ApplicationController
  def index
    @products = Product.includes(:category).page(params[:page])
  end
end
