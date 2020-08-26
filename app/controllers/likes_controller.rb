class LikesController < ApplicationController
  before_action :set_dog, only: %i[create destroy]

  def create
    like = @dog.likes.where(user_id: current_user.id).first_or_initialize

    respond_to do |format|
      if like.save
        format.js { render :create }
      else
        format.json { render json: { errors: like.errors }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @dog.likes.where(user_id: current_user.id).destroy_all

    respond_to do |format|
      format.js { render :destroy }
    end
  end

  private
    def set_dog
      @dog = Dog.find(params[:dog_id])
    end
end
