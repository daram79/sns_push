class PpomppuFreeboardWordsController < ApplicationController
  before_action :set_ppomppu_freeboard_word, only: [:show, :edit, :update, :destroy]

  # GET /ppomppu_freeboard_words
  # GET /ppomppu_freeboard_words.json
  def index
    @ppomppu_freeboard_words = PpomppuFreeboardWord.all
  end

  # GET /ppomppu_freeboard_words/1
  # GET /ppomppu_freeboard_words/1.json
  def show
  end

  # GET /ppomppu_freeboard_words/new
  def new
    @ppomppu_freeboard_word = PpomppuFreeboardWord.new
  end

  # GET /ppomppu_freeboard_words/1/edit
  def edit
  end

  # POST /ppomppu_freeboard_words
  # POST /ppomppu_freeboard_words.json
  def create
    @ppomppu_freeboard_word = PpomppuFreeboardWord.new(ppomppu_freeboard_word_params)

    respond_to do |format|
      if @ppomppu_freeboard_word.save
        format.html { redirect_to @ppomppu_freeboard_word, notice: 'Ppomppu freeboard word was successfully created.' }
        format.json { render :show, status: :created, location: @ppomppu_freeboard_word }
      else
        format.html { render :new }
        format.json { render json: @ppomppu_freeboard_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ppomppu_freeboard_words/1
  # PATCH/PUT /ppomppu_freeboard_words/1.json
  def update
    respond_to do |format|
      if @ppomppu_freeboard_word.update(ppomppu_freeboard_word_params)
        format.html { redirect_to @ppomppu_freeboard_word, notice: 'Ppomppu freeboard word was successfully updated.' }
        format.json { render :show, status: :ok, location: @ppomppu_freeboard_word }
      else
        format.html { render :edit }
        format.json { render json: @ppomppu_freeboard_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ppomppu_freeboard_words/1
  # DELETE /ppomppu_freeboard_words/1.json
  def destroy
    @ppomppu_freeboard_word.destroy
    respond_to do |format|
      format.html { redirect_to ppomppu_freeboard_words_url, notice: 'Ppomppu freeboard word was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ppomppu_freeboard_word
      @ppomppu_freeboard_word = PpomppuFreeboardWord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ppomppu_freeboard_word_params
      params.fetch(:ppomppu_freeboard_word, {})
    end
end
