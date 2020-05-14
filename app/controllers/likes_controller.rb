class LikesController < ApplicationController
  before_action :find_dog

  def create
    if current_user && @dog.user.id != current_user.id
      @dog.likes.find_or_create_by(user_id: current_user.id)
      redirect_to dog_path(@dog), notice: "You have liked #{@dog.name}"
    end
  end

  private

  def find_dog
    @dog = Dog.find(params[:dog_id])
  end
end
