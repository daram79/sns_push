require 'open-uri'
class SnsContentsController < ApplicationController
  before_action :set_sns_content, only: [:show, :edit, :update, :destroy]

  # GET /sns_contents
  # GET /sns_contents.json
  def index
    @sns_contents = SnsContent.all
  end

  # GET /sns_contents/1
  # GET /sns_contents/1.json
  def show
  end

  # GET /sns_contents/new
  def new
    @sns_content = SnsContent.new
  end

  # GET /sns_contents/1/edit
  def edit
  end

  # POST /sns_contents
  # POST /sns_contents.json
  def create
    @sns_content = SnsContent.new(sns_content_params)

    respond_to do |format|
      if @sns_content.save
        format.html { redirect_to @sns_content, notice: 'Sns content was successfully created.' }
        format.json { render :show, status: :created, location: @sns_content }
      else
        format.html { render :new }
        format.json { render json: @sns_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sns_contents/1
  # PATCH/PUT /sns_contents/1.json
  def update
    respond_to do |format|
      if @sns_content.update(sns_content_params)
        format.html { redirect_to @sns_content, notice: 'Sns content was successfully updated.' }
        format.json { render :show, status: :ok, location: @sns_content }
      else
        format.html { render :edit }
        format.json { render json: @sns_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sns_contents/1
  # DELETE /sns_contents/1.json
  def destroy
    @sns_content.destroy
    respond_to do |format|
      format.html { redirect_to sns_contents_url, notice: 'Sns content was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sns_content
      @sns_content = SnsContent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sns_content_params
      params.fetch(:sns_content, {})
    end
end
