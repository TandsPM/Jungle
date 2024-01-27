class Admin::CategoriesController < ApplicationController
  # display list of all categories
  def index
    @categories = Category.all
  end

  #display form for creating a new category
  def new
    @categories = Category.new
  end

  # Handle the created of a new category
  def create
    @categories = Category.new(category_params)

    if @categories.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
  end
end

  private

  def category_params
    params.require(:category).permit(
      :name,
    )
  end
end


