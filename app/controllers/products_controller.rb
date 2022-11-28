class ProductsController < ApplicationController
  def index
    @products = Product.includes(:category).page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    wildcard_search = "%#{params[:keywords]}%"
    category_search = "%#{params[:category_id]}%"

    @products = Product.where("name LIKE ?", wildcard_search).page(params[:page]) if :keywords.present?
    # @products = Product.where(category_id: params[:category_id]).page(params[:page]) if category_id.present?
  end
end
