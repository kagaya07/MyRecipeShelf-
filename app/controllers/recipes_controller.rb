class RecipesController < ApplicationController

  def index
    if params[:genre_id]
      @recipes = Recipe.where(genre_id: params[:genre_id])
    else
      @recipes = Recipe.where(is_valid: true).order(created_at: :desc)
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @cooks = @recipe.cooks
    @mterials = @recipe.mterials
    @comment = Comment.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @cooks = @recipe.cooks
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: "レシピを編集しました!"
    else
      render :edit
    end
  end

  def new
    @recipe = Recipe.new
    @cook = @recipe.cooks.build
    @mterial = @recipe.mterials.build
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      redirect_to homes_shelf_path, notice: "レシピを削除しました"
    else
      render :show
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to recipe_path(@recipe), notice: "レシピを保存しました!"
    else
      render :new
    end
  end


  private
  def recipe_params
    params.require(:recipe).permit(:name, :image, :amount, :explanation, :is_valid, :genre_id, mterials_attributes: [:id, :name, :puantity, :_destroy],cooks_attributes: [:id, :image, :body, :_destroy])
  end
end
