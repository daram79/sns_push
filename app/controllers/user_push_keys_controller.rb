class UserPushKeysController < ApplicationController
  before_action :set_user_push_key, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :only => [:add_user_push_key]

  # GET /user_push_keys
  # GET /user_push_keys.json
  def index
    @user_push_keys = UserPushKey.all
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
    user_id = params[:user_id]
    
#   sns_id도 같이 검색
    # sns_push_key = SnsPushKey.where(key: key)
    sns_push_key = SnsPushKey.where(sns_id: sns_id, key: key)
    if sns_push_key.blank?
      #sns_id 입력
      # sns_push_key = SnsPushKey.create(key: key)
      sns_push_key = SnsPushKey.create(sns_id: sns_id, key: key)
    end
    # UserPushKey.create(sns_push_key_id: sns_push_key.id)
    UserPushKey.create(user_id: user_id, sns_push_key_id: sns_push_key.id)
    
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
