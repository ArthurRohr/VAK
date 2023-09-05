class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @recipe = Recipe.find(params[:recipe_id])
  end

  def create
    @review = Review.new(review_params)
    @recipe = Recipe.find(params[:recipe_id])
    @review.recipe = @recipe
    @review.user = current_user
    if @review.save
      redirect_to recipe_path(@recipe)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to recipe_path(@review.recipe)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
