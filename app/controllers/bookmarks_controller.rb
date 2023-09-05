class BookmarksController < ApplicationController
  def new
    @bookmark = Bookmark.new
    redirect_to recipe_path(params[:recipe_id])
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @bookmark = Bookmark.new
    @bookmark.recipe = @recipe
    @bookmark.user = current_user
    if @bookmark.save
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def index
    @bookmarks = current_user.bookmarks
  end


  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to recipe_path(@bookmark.recipe)
  end
end

# @recipe = Recipe.find(params[:recipe_id])
# bookmark = Bookmark.new(user_id: current_user.id, recipe_id: @recipe.id)
# bookmark.save
# redirect_to recipe_path(@recipe)
