class UserPushContentsController < ApplicationController
  before_action :set_user_push_content, only: [:show, :edit, :update, :destroy]

  # GET /user_push_contents
  # GET /user_push_contents.json
  def index
    user_id = session[:user_id] = params[:user_id]
    push_content_id = params[:push_content_id]
    @sns_content_id = 0

    if push_content_id != nil
      sns_content = SnsContent.find_by_content_id(push_content_id)
      @sns_content_id = sns_content.id
    end
    @notices = Notice.where(is_show: true)
    @user_push_contents = UserPushContent.where(user_id: user_id).order("id desc").first(100)
  end
  
  def my
    user_id = session[:user_id] = params[:user_id]
    push_content_id = params[:push_content_id]
    user_nick_name = User.find(user_id).nick_name
    if user_nick_name
      @sns_content_id = 0
      if push_content_id != nil
        sns_content = SnsContent.find_by_content_id(push_content_id)
        @sns_content_id = sns_content.id
      end
      @contents = SnsContent.where(writer: user_nick_name).order("id desc").first(20)
    end
  end

  # GET /user_push_contents/1
  # GET /user_push_contents/1.json
  def show
  end

  # GET /user_push_contents/new
  def new
    @user_push_content = UserPushContent.new
  end

  # GET /user_push_contents/1/edit
  def edit
  end

  # POST /user_push_contents
  # POST /user_push_contents.json
  def create
    @user_push_content = UserPushContent.new(user_push_content_params)

    respond_to do |format|
      if @user_push_content.save
        format.html { redirect_to @user_push_content, notice: 'User push content was successfully created.' }
        format.json { render :show, status: :created, location: @user_push_content }
      else
        format.html { render :new }
        format.json { render json: @user_push_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_push_contents/1
  # PATCH/PUT /user_push_contents/1.json
  def update
    respond_to do |format|
      if @user_push_content.update(user_push_content_params)
        format.html { redirect_to @user_push_content, notice: 'User push content was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_push_content }
      else
        format.html { render :edit }
        format.json { render json: @user_push_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_push_contents/1
  # DELETE /user_push_contents/1.json
  def destroy
    @user_push_content.destroy
    respond_to do |format|
      format.html { redirect_to user_push_contents_url, notice: 'User push content was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_push_content
      @user_push_content = UserPushContent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_push_content_params
      params.fetch(:user_push_content, {})
    end
end
