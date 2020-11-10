class LikesController < ApplicationController
  before_action :authenticate_user!, :set_likes, only: %i[destroy]

  def new
    @like = Like.new
  end

  def create
    @like = Like.new(like_params)
    @like.user_id = current_user.id
    @dog = Dog.find(params[:dog_id])

    respond_to do |format|
      if @like.save
        format.html { redirect_to @dog, notice: 'Like was successfully created.' }
        format.json { render :show, status: :created, location: @dog }
      else
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def set_likes
    @like = Like.find(params[:id])
    @dog = Dog.find(@like.dog.id)
  end

  def like_params
    params.permit(:user_id, :dog_id)
  end
end
