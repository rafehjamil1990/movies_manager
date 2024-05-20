class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    @movies_actors = MoviesActor.left_joins(:movie).includes(:actor, :movie).order('avg_rating DESC')

    if params[:search_actor].present?
      actors = Actor.where('lower(name) LIKE ?', "%#{params[:search_actor].downcase}%").pluck(:id)
      @movies_actors = @movies_actors.where(actor_id: actors)
    end
  end
end
