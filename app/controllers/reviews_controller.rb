class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reviews = Review.includes(:movie).all
  end
end
