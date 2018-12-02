class DogsController < ApplicationController
  before_action :requires_permission, only: :edit
  before_action :set_dog, only: [:show, :edit, :update, :destroy, :upvote, :downvote]

  # GET /dogs
  # GET /dogs.json
  def index
    # @dogs = Dog.all
    @dogs = Dog.paginate(:page => params[:page], :per_page => 5).order('last_liked DESC, cached_votes_up DESC')
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
    @dog = current_user.dogs.create(dog_params)

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
    @dog.destroy
    respond_to do |format|
      format.html { redirect_to dogs_url, notice: 'Dog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PUT /dogs/1/like
  def upvote
    puts current_user.id
    @dog.upvote_by current_user
    if @dog.vote_registered?
      # TODO: Confirm that the Time.now.beginning_of_hour is datetimestamp rounded to current hour
      @dog.update_attribute(:last_liked, Time.now.beginning_of_hour)
    end
    redirect_back fallback_location: root_path
  end

  # PUT /dogs/1/dislike
  def downvote
    puts current_user.id
    @dog.downvote_from current_user
    puts @dog.vote_registered?
    redirect_back fallback_location: root_path
  end

  public
    def is_owned_by_current?(dog)
      return false unless current_user
      @dog.user_id == current_user.id
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dog
      @dog = Dog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dog_params
      params.require(:dog).permit(:name, :description, :images)
    end

    def requires_permission
      @dog = Dog.find(params[:id])
      if !is_owned_by_current?(@dog)
        redirect_to root_path
      end
    end

    helper_method :is_owned_by_current?
end
