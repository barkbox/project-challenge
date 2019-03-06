class LikesController < ApplicationController
  before_action :authenticate_user!

def create
  @like = Like.new(user_id: current_user.id, dog_id: params[:dog_id])
  @like.save
  @dog = Dog.find(params[:dog_id])
  redirect_to @dog

end

def destroy
  @dog = Dog.find(params[:dog_id])
  @like = Like.find_by(user_id: current_user.id, dog_id: params[:dog_id])
  @like.delete
  redirect_to @dog
end


end
