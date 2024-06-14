class UserIngredientsController < ApplicationController
  # def new
  #   @user_ingredient = UserIngredient.new
  # end

  def create
    @ingredient = Ingredient.find_or_create_by(name: params[:user_ingredient][:ingredient])
    @user_ingredient = UserIngredient.new(user: current_user, ingredient: @ingredient)
    @user_ingredient.save
    redirect_to recipes_path
  end

  def edit
  end

  def update
  end

  def destroy
    @user_ingredient = UserIngredient.find(params[:id])
    @user_ingredient.destroy
  end

  private

  def user_ingredient_params
    params.require(:user_ingredient).permit(:user_id, :ingredient_id)
  end
end
