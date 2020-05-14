class DogsController < ApplicationController
  before_action :set_dog, only: [:show, :edit, :update, :destroy]
  before_action :set_owner, only: [:edit, :update, :destroy]

  # GET /dogs
  # GET /dogs.json
  def index
    if params[:sort_by_likes]
      dogs_arr = Dog.all.sort_by {|d| d.likes_in_last_hour }
      @dogs = Kaminari.paginate_array(dogs_arr).page(params[:page]).per(5)
    else
      @dogs = Dog.all.page params[:page]
    end
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
    unless @owner
      redirect_back fallback_location: { action: "index" },
                    notice: "This change may only be made by the dog's owner"
    end
  end

  # POST /dogs
  # POST /dogs.json
  def create
    @dog = Dog.new(dog_params)

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
        if params[:dog][:images]
          params[:dog][:images].each do |image|
            @dog.images.attach(image.last) if image.present?
          end
        end

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
    @dog.destroy if @owner
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

    def set_owner
      if current_user && current_user.id == @dog.user.id
        @owner = @dog.user
      else
        redirect_back fallback_location: { action: "index" },
                      notice: "This change may only be made by the dog's owner"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dog_params
      params.require(:dog).permit(:name, :description, :images, :user_id)
    end
end
