class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # skip_before_filter :verify_authenticity_token, :only => [:index, :show]
  skip_before_filter :verify_authenticity_token, :only => [:create, :update_registration_id, :add_visit_history]

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
  
  def get_menu
    menu = MainMenu.all
    render json: menu
  end
  
  def get_user_visit_history
    menu = MainMenu.all
    render json: menu
  end
  
  def setting
    @user_id = user_id = params[:id]
    
    on = [true, "ON"]
    off = [false, "OFF"]
    
    @on_off_hash = Hash.new
    @on_off_hash[:on] = on
    @on_off_hash[:off] = off
    
    @user = User.find(user_id)
  end
  
  def user_visit_history
    user_id = params[:id]
    session[:user_id] = user_id
    @visit_histories = VisitHistory.where(user_id: user_id, is_delete: false).order("id desc").limit(1000)
  end
  
  def delete_visit_history
    history_id = params[:history_id]
    visit_history = VisitHistory.find(history_id)
    visit_history.update(is_delete: true)
    render json: {status: :ok}
  end
  
  def set_user_keyword_mode
    sns_id = params[:sns_id]
    keyword_mode = params[:keyword_mode]
    
    only_title = false
    if keyword_mode.eql?("only_title")
      only_title = true
    end
    
    user_id = session[:user_id]
    user_keyword_mode = UserKeywordMode.where(user_id: user_id, sns_id: sns_id)
    unless user_keyword_mode.blank?
      user_keyword_mode.destroy_all
    end
    
    UserKeywordMode.create(user_id: user_id, sns_id: sns_id, only_title: only_title)
    
    render json: {status: :ok}
  end
  
  def set_push_off_time
    user_id = params[:id]
    user = User.find(user_id)
    start_time_hour = params[:start_time_hour]
    start_time_min = params[:start_time_min]
    
    start_time = start_time_hour + ":" + start_time_min + ":00" 
    
    
    end_time_hour = params[:end_time_hour]
    end_time_min = params[:end_time_min]
    end_time = end_time_hour + ":" + end_time_min + ":00"
    
    user.update(push_off_start_time: start_time, push_off_end_time: end_time)
    render json: {status: :ok}
    
  end
  
  def set_is_push
    user_id = params[:id]
    is_push = params[:is_push]
    user = User.find(user_id)
    user.update(is_push: is_push)
    render json: {status: :ok}
  end
  
  def set_is_push_off_time
    user_id = params[:id]
    is_push_off_time = params[:is_push_off_time]
    user = User.find(user_id)
    user.update(is_push_off_time: is_push_off_time)
    render json: {status: :ok}
  end
  
  def set_is_push_comment
    user_id = params[:id]
    is_push_comment = params[:is_push_comment]
    user = User.find(user_id)
    user.update(is_push_comment: is_push_comment)
    render json: {status: :ok}
  end
  
  def set_nick_name
    user_id = params[:id]
    nick_name = params[:nick_name]
    user = User.find(user_id)
    user.update(nick_name: nick_name)
    render json: {status: :ok}
  end
  
  def add_visit_history
    user_id = params[:user_id]
    url = params[:url].split("&page")[0]
    title = params[:title]
    
    tmp_url = url.clone
    tmp_url.slice! "http://"
    if tmp_url != title && "SnsPush" != title && title.include?("-")
      visit_history = VisitHistory.where(user_id: user_id, url: url)
      VisitHistory.create(user_id: user_id, url: url, title: title) if visit_history.blank?
    end
    render json: {status: :ok}
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
