class BoardsController < ApplicationController
  before_action :set_board, only: %i[ show edit update destroy execute_recurrent_cards ]

  # GET /boards or /boards.json
  def index
    @boards = Board.all
  end

  # GET /boards/1 or /boards/1.json
  def show
  end

  # GET /boards/new
  def new
    @board = Board.new
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards or /boards.json
  def create
    @board = Board.new(board_params)

    respond_to do |format|
      if @board.save
        format.html { redirect_to board_url(@board), notice: "Board was successfully created." }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1 or /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to board_url(@board), notice: "Board was successfully updated." }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1 or /boards/1.json
  def destroy
    @board.destroy

    respond_to do |format|
      format.html { redirect_to boards_url, notice: "Board was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def execute_recurrent_cards
    user = @board.user
    msg = "Board recurrent cards created."
    @board.recurrent_cards.each {|card|
      card.lists.each {|list|
        list_id = list.trello_id
        body = {
          name: card.name,
          idLabels: card.labels.map { |label| label.trello_id},

        }
        headers = {
          "Content-Type": "application/json"
        }
        boards_response = HTTParty.post("https://api.trello.com/1/cards?key=#{user.key}&token=#{user.token}&idList=#{list_id}", body: body.to_json, headers: headers)
        if boards_response.code != 200
          msg = boards_response.body
        else
          msg = msg + " #{card.name}"
        end
      }
    }
    respond_to do |format|
      format.html { redirect_to @board, notice: msg }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def board_params
      params.require(:board).permit(:id, :name, :user_id, :short_link)
    end
end
