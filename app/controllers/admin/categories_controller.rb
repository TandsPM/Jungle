class Admin::CategoriesController < ApplicationController
  # display list of all categories
  def index
    @category = Category.all
  end

  #display form for creating a new category
  def new
    @category = Category.new
  end

  # Handle the created of a new category
  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
  end

  private

  def category_params
    params.require(:category).permit(
      :name,
      :description,
      :category_id,
      # :quantity,
      # :image,
      # :price
    )
  end
end
end

