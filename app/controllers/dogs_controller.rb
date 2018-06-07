class DogsController < ApplicationController
  def index
    @dogs = Dog.last(10)
  end

  def create
    @dog = Dog.new(dog_params)
    if @dog.save
      @dog.images.attach(params[:image])
      redirect_to @dog
    else
      render 'new', alert: @dog.errors.full_sentences
    end
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
