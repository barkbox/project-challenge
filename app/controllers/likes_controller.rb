class LikesController < ApplicationController
  def create
    @like = Like.new(dog_params)
    respond_to do |format|
      if @like.save
        @number_of_likes = Like.where(dog_id: dog_params[:dog_id]).count
        format.js { render :create }
      else
        format.js { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def dog_params
    params.require(:like).permit(:dog_id, :user_id)
  end
end
