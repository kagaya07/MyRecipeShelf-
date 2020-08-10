class CommentsController < ApplicationController
  def create
  	recipe = Recipe.find(params[:recipe_id])
  	comment = Comment.new(comment_params)
  	comment.user_id = current_user.id
    comment.recipe_id = recipe.id
    comment.save
    redirect_to recipe_path(recipe), notice: "コメントしました!"
  end

  def destroy
  	Comment.find_by(id: params[:id], recipe_id: params[:recipe_id]).destroy
    redirect_to recipe_path(params[:recipe_id])
  end

  private
  def comment_params
  	params.require(:comment).permit(:body)
  end
end
