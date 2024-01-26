# Display a count of how many products are in the database
# Display a count of how many categories are in the database

class Admin::DashboardController < ApplicationController
  # def index
  #   @product_count = Product.count
  # end

  def show
    @product_count = Product.count
  end
end
