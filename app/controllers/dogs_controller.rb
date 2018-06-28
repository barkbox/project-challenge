class DogsController < ApplicationController
  def index
    @dogs = Dog.last(10)
  end

  def create
    @dog = Dog.new(dog_params)
    if @dog.save
      @dog.images.attach(params[:dog][:image])
      redirect_to @dog
    else
      render 'new', alert: @dog.errors.full_sentences
    end
  end

  def update
    dog.images.attach(params[:dog][:image])
    dog.update_attributes(dog_params)
    redirect_to dog
  end


  private

  def dog_params
    params.require(:dog).permit(:name, :description, :images)
  end

  def dog
    Dog.find(params[:id])
  end
  helper_method :dog
end
