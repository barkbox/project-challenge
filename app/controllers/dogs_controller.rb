class DogsController < ApplicationController
  before_action :set_dog, only: [:show, :edit, :update, :destroy, :like]

  # GET /dogs
  # GET /dogs.json
  def index
    @dogs = Dog.paginate(page: params[:page], per_page: 5)
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
    redirect_to(@dog, notice: 'You do not own this dog') unless @dog.owner == current_user
  end

  # POST /dogs
  # POST /dogs.json
  def create
    @dog = Dog.new(dog_params)
    @dog.user = current_user

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
    redirect_to(@dog, notice: 'You do not own this dog.') unless @dog.owner == current_user
    @dog.destroy
    respond_to do |format|
      format.html { redirect_to dogs_url, notice: 'Dog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /dogs/1/like
  # GET /dogs/1/like.json
  def like
    redirect_to(@dog, notice: 'You own this dog.') if @dog.owner == current_user

    if current_user.voted_for? @dog
      status = 'unliked'
      @dog.unliked_by current_user
    else
      status = 'liked'
      @dog.liked_by current_user
    end

    respond_to do |format|
      format.html { redirect_to @dog, notice: "#{@dog.name} successfully #{status}." }
      format.json { render :show, status: :ok, location: @dog }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dog
      p params
      @dog = Dog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dog_params
      params.require(:dog).permit(:name, :description, images: [])
    end
end
