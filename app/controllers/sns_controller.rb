class SnsController < ApplicationController
  before_action :set_sn, only: [:show, :edit, :update, :destroy]

  # GET /sns
  # GET /sns.json
  def index
    @sns = Sn.all
  end

  # GET /sns/1
  # GET /sns/1.json
  def show
  end

  # GET /sns/new
  def new
    @sn = Sn.new
  end

  # GET /sns/1/edit
  def edit
  end

  # POST /sns
  # POST /sns.json
  def create
    @sn = Sn.new(sn_params)

    respond_to do |format|
      if @sn.save
        format.html { redirect_to @sn, notice: 'Sn was successfully created.' }
        format.json { render :show, status: :created, location: @sn }
      else
        format.html { render :new }
        format.json { render json: @sn.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sns/1
  # PATCH/PUT /sns/1.json
  def update
    respond_to do |format|
      if @sn.update(sn_params)
        format.html { redirect_to @sn, notice: 'Sn was successfully updated.' }
        format.json { render :show, status: :ok, location: @sn }
      else
        format.html { render :edit }
        format.json { render json: @sn.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sns/1
  # DELETE /sns/1.json
  def destroy
    @sn.destroy
    respond_to do |format|
      format.html { redirect_to sns_url, notice: 'Sn was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sn
      @sn = Sn.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sn_params
      params.fetch(:sn, {})
    end
end
