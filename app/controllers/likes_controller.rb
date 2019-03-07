class LikesController < ApplicationController
  before_action :require_login

  # POST /dogs/:dog_id/likes
  # POST /dogs.json
  def create
    @like = Like.new(like_params)
    @like.liker_id = current_user.id
    @like.dog_id = params[:dog_id]

    respond_to do |format|
      if @like.save
        @dog = Dog.find(params[:dog_id])

        format.html { redirect_to @dog } 
        format.json { render :show, status: :created, location: @dog }

      else
        format.json { render json: @like.errors.full_messages, status: 422 }
      end
    end

  end

  # DELETE /likes/1
  # DELETE /likes/1.json
  def destroy
    @like = Like.find(params[:id])  
    @dog = Dog.find(@like.dog_id)
    @like.destroy

    respond_to do |format|
      format.html { redirect_to @dog } 
    end
  end

  private
  def like_params
    params.permit(:dog_id, :liker_id)
  end
end