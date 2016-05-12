class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # skip_before_filter :verify_authenticity_token, :only => [:index, :show]
  skip_before_filter :verify_authenticity_token, :only => [:create, :update_registration_id]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end
  
  # def set_user_recommend_push_count
    # recommend_push_count = params[:count]
    # recommend_push_count = nil if recommend_push_count == "nil"
    # user = User.find(session[:user_id])
    # user.update(recommend_push_count: recommend_push_count)
    # render json: {count: user.recommend_push_count}
  # end

  # POST /users
  # POST /users.json
  def create
    # @user = User.new(user_params)
    if params[:msg] == "create"
      user = User.create()
    end
    
    render json: {user_id: user.id}

    # respond_to do |format|
      # format.html { redirect_to @user, notice: 'User was successfully created.' }
      # format.json { render :show, status: :created, location: user.id }
      # # if @user.save
        # # format.html { redirect_to @user, notice: 'User was successfully created.' }
        # # format.json { render :show, status: :created, location: @user }
      # # else
        # # format.html { render :new }
        # # format.json { render json: @user.errors, status: :unprocessable_entity }
      # # end
    # end
  end
  
  def update_registration_id
    user = User.find(params[:id])
    user.update(registration_id: params[:registration_id])
    render json: {user_id: user.id}
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.fetch(:user, {})
    end
end
