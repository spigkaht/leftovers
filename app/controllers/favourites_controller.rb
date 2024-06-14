class FavouritesController < ApplicationController
  # POST /recipes/:recipe_id/favourites
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @favourite = Favourite.new(
      user: current_user,
      recipe: @recipe
    )
    @favourite.save
    redirect_to recipes_path
  end

  # DELETE /favourites/:id
  def destroy
    @favourite = Favourite.find(params[:id])
    @favourite.destroy

    redirect_to recipes_path, status: :see_other
  end

  private

  # def set_recipe
  #   @recipe = Recipe.find(params[:id])
  # end

  def favourite_params
    params.require(:favourite).permit(:recipe_id)
  end
end
