class UserPushKeysController < ApplicationController
  before_action :set_user_push_key, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :only => [:add_user_push_key]

  # GET /user_push_keys
  # GET /user_push_keys.json
  def index
    if params[:user_id]
      user_id = session[:user_id] = params[:user_id]
    elsif session[:user_id]
      user_id = session[:user_id]
    end
    
    @sns_id = params[:sns_id]
    @user_recommend_push_count = RecommendPushCount.where(user_id: user_id, sns_id: @sns_id).pluck(:count).join.to_i
    # @user_recommend_push_count = User.find(user_id).recommend_push_count
    @sns_list = Sn.all
    @sns_name = Sn.find(@sns_id).name
    # @user_push_keys = UserPushKey.where(user_id: 1).order("id desc")
    @user_push_keys = UserPushKey.where(user_id: user_id).includes(:sns_push_key).where(sns_push_keys:{sns_id: @sns_id})
    # @user_push_keys = UserPushKey.all.order("id desc")
  end

  # GET /user_push_keys/1
  # GET /user_push_keys/1.json
  def show
  end

  # GET /user_push_keys/new
  def new
    @user_push_key = UserPushKey.new
  end

  # GET /user_push_keys/1/edit
  def edit
  end
  
  def set_user_recommend_push_count
    user_id = session[:user_id]
    sns_id = params[:sns_id]
    count = params[:count]
    count = nil if count == "nil"
    recommend_push_count = RecommendPushCount.where(user_id: user_id, sns_id: sns_id).first
    if recommend_push_count.blank?
      recommend_push_count = RecommendPushCount.create(user_id: user_id, sns_id: sns_id, count: count)
    else
      recommend_push_count.update(count: count)
    end
    # user = User.find(session[:user_id])
    # user.update(recommend_push_count: recommend_push_count)
    render json: {count: recommend_push_count.count, sns_id: sns_id} 
  end

  # POST /user_push_keys
  # POST /user_push_keys.json
  def create
    @user_push_key = UserPushKey.new(user_push_key_params)

    respond_to do |format|
      if @user_push_key.save
        format.html { redirect_to @user_push_key, notice: 'User push key was successfully created.' }
        format.json { render :show, status: :created, location: @user_push_key }
      else
        format.html { render :new }
        format.json { render json: @user_push_key.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def add_user_push_key
#     사이트/유저id 입력 받음
# 1. sns키에서 키워드 검색
# 2. 있으면 유저키워드만 입력
# 3. 없으면 sns입력후 유저 키워드 입력
    key = params[:user_push_key]
    sns_id = params[:sns_id]
    user_id = session[:user_id]
    
#   sns_id도 같이 검색
    sns_push_key = SnsPushKey.where(sns_id: sns_id, key: key).first
    
    if sns_push_key.blank?      
      #sns_id 입력
      # sns_push_key = SnsPushKey.create(key: key)
      sns_push_key = SnsPushKey.create(sns_id: sns_id, key: key)
    end

#     이미 등록되어 있는 키워드인지 검색
    user_push_key = UserPushKey.where(user_id: user_id, sns_push_key_id: sns_push_key.id)
    
    UserPushKey.create(user_id: user_id, sns_push_key_id: sns_push_key.id) if user_push_key.blank?
    
    render json: {status: :ok}
  end
  
  def delete_user_push_key
    user_push_key = UserPushKey.find(params[:key_id])
    user_push_key.destroy
    render json: {status: :ok}
  end

  # PATCH/PUT /user_push_keys/1
  # PATCH/PUT /user_push_keys/1.json
  def update
    respond_to do |format|
      if @user_push_key.update(user_push_key_params)
        format.html { redirect_to @user_push_key, notice: 'User push key was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_push_key }
      else
        format.html { render :edit }
        format.json { render json: @user_push_key.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_push_keys/1
  # DELETE /user_push_keys/1.json
  def destroy
    @user_push_key.destroy
    respond_to do |format|
      format.html { redirect_to user_push_keys_url, notice: 'User push key was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_push_key
      @user_push_key = UserPushKey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_push_key_params
      params.fetch(:user_push_key, {})
    end
end
