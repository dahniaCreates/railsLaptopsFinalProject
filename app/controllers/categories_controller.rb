class CategoriesController < ApplicationController
  def index
    @categories = Category.all.page(params[:page])
  end

  def show
    @category_name = Category.find(params[:id])
    @laptops_in_category = Product.where(category_id: params[:id])
  end
end
