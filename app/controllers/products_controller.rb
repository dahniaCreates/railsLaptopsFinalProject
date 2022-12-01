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

    if params[:category_id].present? && params[:keywords].present?
      @products = Product.where(category_id: params[:category_id]).where("name LIKE ?", wildcard_search).page(params[:page])
    elsif params[:category_id].present?
      @products = Product.where(category_id: params[:category_id]).page(params[:page])
    else
      @products = Product.where("name LIKE ?", wildcard_search).page(params[:page])
    end

    @category = Category.where(id: params[:category_id])
  end

  def filter
    @on_sales = Product.where.not(discount_price: nil)
  end

  def update
    @updates = Product.where(updated_at: 3.days.ago..)
  end
end
