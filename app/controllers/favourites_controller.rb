class FavouritesController < ApplicationController
  def index
    @favourite = Favourite.all
  end

  def new
    @favourite = Favourite.new
  end

  def create
    @favourite = Favourite.new(favourite_params)
    @favourite.save
    redirect_to recipes_path
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @favourite.destroy
  end

  private

  # def set_recipe
  #   @recipe = Recipe.find(params[:id])
  # end

  def favourite_params
    params.require(:favourite).permit(:user_id, :recipe_id)
  end
end
