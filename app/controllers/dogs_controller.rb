require 'will_paginate/array'

class DogsController < ApplicationController
  before_action :set_dog, only: [:show, :edit, :update, :destroy]

  # GET /dogs
  # GET /dogs.json
  def index
    unliked_dogs = []
    liked_dogs = []
    liked_ids = Like.where('created_at > ?', 1.hours.ago).pluck(:dog_id)
    dogs = liked_ids.map { |id| Dog.find(id) }
    Dog.all.each do |dog|
      if liked_ids.include?(dog.id)
        liked_dogs << dog
      else
        unliked_dogs << dog
      end
    end
    liked_dogs = dogs.sort_by { |dog| dog.likes.count }.reverse
    all_dogs = liked_dogs.concat(unliked_dogs)
    @dogs = all_dogs.paginate(:page => params[:page], :per_page => 5)

    # @dogs = Dog.select('dogs.*, count(likes.id) as likes_count')
    # .joins('LEFT OUTER JOIN likes on likes.post_id = dogs.id')
    # .group_by('dogs.id')
    # .order('likes_count desc')
    # .where('created_at > ?', 1.hours.ago)
    # .paginate(:page => params[:page], :per_page => 5)

    # @dogs = Dog.left_joins(:likes)
    # .group(:id)
    # .order('COUNT(likes.id) DESC')
    # .where('created_at > ?', 1.hours.ago)
    # .paginate(:page => params[:page], :per_page => 5)
  end

  # GET /dogs/1
  # GET /dogs/1.json
  def show
  end

  # GET /dogs/new
  def new
    @dog = Dog.new
  end

  # GET /dogs/1/edit
  def edit
  end

  # POST /dogs
  # POST /dogs.json
  def create
    @dog = Dog.new(dog_params)
    @dog.owner = current_user

    respond_to do |format|
      if @dog.save
        @dog.images.attach(params[:dog][:image]) if params[:dog][:image].present?

        format.html { redirect_to @dog, notice: 'Dog was successfully created.' }
        format.json { render :show, status: :created, location: @dog }
      else
        format.html { render :new }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dogs/1
  # PATCH/PUT /dogs/1.json
  def update
    respond_to do |format|

      if @dog.owner
        if @dog.owner.id != current_user.id
          flash[:notice] = "*You can't EDIT someone else's dog!*"
          redirect_to @dog
        end
        return
      end

      if @dog.update(dog_params)
        @dog.images.attach(params[:dog][:image]) if params[:dog][:image].present?

        format.html { redirect_to @dog, notice: 'Dog was successfully updated.' }
        format.json { render :show, status: :ok, location: @dog }
      else
        format.html { render :edit }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dogs/1
  # DELETE /dogs/1.json
  def destroy
    if @dog.owner
      if @dog.owner.id != current_user.id
        flash[:notice] = "*You can't just DELETE someone else's dog!*"
        redirect_to @dog
        return
      end
    end

    @dog.destroy
    respond_to do |format|
      format.html { redirect_to dogs_url, notice: 'Dog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dog
      @dog = Dog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dog_params
      params.require(:dog).permit(:name, :description, images: [] )
    end
end
