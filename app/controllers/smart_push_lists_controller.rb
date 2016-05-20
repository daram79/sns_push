class SmartPushListsController < ApplicationController
  before_action :set_smart_push_list, only: [:show, :edit, :update, :destroy]

  # GET /smart_push_lists
  # GET /smart_push_lists.json
  def index
    # @smart_push_lists = SmartPushList.all
    @smart_push_lists = SmartPushList.where(is_show: true).order("id desc")
  end

  # GET /smart_push_lists/1
  # GET /smart_push_lists/1.json
  def show
  end

  # GET /smart_push_lists/new
  def new
    @smart_push_list = SmartPushList.new
  end

  # GET /smart_push_lists/1/edit
  def edit
  end

  # POST /smart_push_lists
  # POST /smart_push_lists.json
  def create
    @smart_push_list = SmartPushList.new(smart_push_list_params)

    respond_to do |format|
      if @smart_push_list.save
        format.html { redirect_to @smart_push_list, notice: 'Smart push list was successfully created.' }
        format.json { render :show, status: :created, location: @smart_push_list }
      else
        format.html { render :new }
        format.json { render json: @smart_push_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /smart_push_lists/1
  # PATCH/PUT /smart_push_lists/1.json
  def update
    respond_to do |format|
      if @smart_push_list.update(smart_push_list_params)
        format.html { redirect_to @smart_push_list, notice: 'Smart push list was successfully updated.' }
        format.json { render :show, status: :ok, location: @smart_push_list }
      else
        format.html { render :edit }
        format.json { render json: @smart_push_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /smart_push_lists/1
  # DELETE /smart_push_lists/1.json
  def destroy
    @smart_push_list.destroy
    respond_to do |format|
      format.html { redirect_to smart_push_lists_url, notice: 'Smart push list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_smart_push_list
      @smart_push_list = SmartPushList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def smart_push_list_params
      params.fetch(:smart_push_list, {})
    end
end
