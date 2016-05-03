class SnsPushKeysController < ApplicationController
  before_action :set_sns_push_key, only: [:show, :edit, :update, :destroy]

  # GET /sns_push_keys
  # GET /sns_push_keys.json
  def index
    @sns_push_keys = SnsPushKey.all
  end

  # GET /sns_push_keys/1
  # GET /sns_push_keys/1.json
  def show
  end

  # GET /sns_push_keys/new
  def new
    @sns_push_key = SnsPushKey.new
  end

  # GET /sns_push_keys/1/edit
  def edit
  end

  # POST /sns_push_keys
  # POST /sns_push_keys.json
  def create
    @sns_push_key = SnsPushKey.new(sns_push_key_params)

    respond_to do |format|
      if @sns_push_key.save
        format.html { redirect_to @sns_push_key, notice: 'Sns push key was successfully created.' }
        format.json { render :show, status: :created, location: @sns_push_key }
      else
        format.html { render :new }
        format.json { render json: @sns_push_key.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sns_push_keys/1
  # PATCH/PUT /sns_push_keys/1.json
  def update
    respond_to do |format|
      if @sns_push_key.update(sns_push_key_params)
        format.html { redirect_to @sns_push_key, notice: 'Sns push key was successfully updated.' }
        format.json { render :show, status: :ok, location: @sns_push_key }
      else
        format.html { render :edit }
        format.json { render json: @sns_push_key.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sns_push_keys/1
  # DELETE /sns_push_keys/1.json
  def destroy
    @sns_push_key.destroy
    respond_to do |format|
      format.html { redirect_to sns_push_keys_url, notice: 'Sns push key was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sns_push_key
      @sns_push_key = SnsPushKey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sns_push_key_params
      params.fetch(:sns_push_key, {})
    end
end
