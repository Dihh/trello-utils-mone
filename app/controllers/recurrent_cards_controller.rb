class RecurrentCardsController < ApplicationController
  before_action :set_recurrent_card, only: %i[ show edit update destroy ]

  # GET /recurrent_cards or /recurrent_cards.json
  def index
    @recurrent_cards = RecurrentCard.all
  end

  # GET /recurrent_cards/1 or /recurrent_cards/1.json
  def show
  end

  # GET /recurrent_cards/new
  def new
    @recurrent_card = RecurrentCard.new
  end

  # GET /recurrent_cards/1/edit
  def edit
  end

  # POST /recurrent_cards or /recurrent_cards.json
  def create
    @recurrent_card = RecurrentCard.new(recurrent_card_params)
    set_recurrent_card_labels
    set_recurrent_card_lists
    respond_to do |format|
      if @recurrent_card.save
        format.html { redirect_to recurrent_card_url(@recurrent_card), notice: "Recurrent card was successfully created." }
        format.json { render :show, status: :created, location: @recurrent_card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recurrent_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recurrent_cards/1 or /recurrent_cards/1.json
  def update
    set_recurrent_card_labels
    set_recurrent_card_lists
    respond_to do |format|
      if @recurrent_card.update(recurrent_card_params)
        format.html { redirect_to recurrent_card_url(@recurrent_card), notice: "Recurrent card was successfully updated." }
        format.json { render :show, status: :ok, location: @recurrent_card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recurrent_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recurrent_cards/1 or /recurrent_cards/1.json
  def destroy
    @recurrent_card.destroy

    respond_to do |format|
      format.html { redirect_to recurrent_cards_url, notice: "Recurrent card was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recurrent_card
      @recurrent_card = RecurrentCard.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recurrent_card_params
      params.require(:recurrent_card).permit(:name, :board_id)
    end

    def set_recurrent_card_labels
      @recurrent_card.labels = Label.where(id: params["labels"])
    end

    def set_recurrent_card_lists
      @recurrent_card.lists = List.where(id: params["lists"])
    end
end
