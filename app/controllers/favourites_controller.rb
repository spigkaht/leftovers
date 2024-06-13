class FavouritesController < ApplicationController
  def index
    @favourite = Favourite.all
  end

  def new
    @favourite = Favourite.new(favourite_params)
  end

  def create
    @favourite = Favourite.new(favourite_params)
    @favourite.save
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @favourite.destroy
  end

  private

  def favourite_params
    params.require(:favourite).permit(:user_id, :recipe_id)
  end
end
