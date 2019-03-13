class LikesController < ApplicationController
  before_action :authenticate_user!

def create
  @like = Like.find_by(user_id: current_user.id, dog_id: params[:dog_id])
  @dog = Dog.find(params[:dog_id])
  if @dog.owner.id == current_user.id
    flash[:notice] = "*You can't like your own dog!*"
    redirect_to @dog
  elsif @like
    flash[:notice] = "*You can't like the same dog twice!*"
    redirect_to @dog
  else 
    @like = Like.new(user_id: current_user.id, dog_id: params[:dog_id])
    @like.save
    redirect_to @dog
  end
end

def destroy
  @dog = Dog.find(params[:dog_id])
  @like = Like.find_by(user_id: current_user.id, dog_id: params[:dog_id])
  if !@like
    flash[:notice] = "*Why would you want to UNlike a dog you haven't even liked?!... No.*"
    redirect_to @dog
  else
    @like.delete
    redirect_to @dog
  end
end


end
