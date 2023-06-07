class AnalysesController < ApplicationController
  before_action :set_analysis, only: %i[ show edit update destroy edit_date_values update_date_values sync_data ]

  # GET /analyses or /analyses.json
  def index
    @analyses = Analysis.all
  end

  # GET /analyses/1 or /analyses/1.json
  def show
  end

  # GET /analyses/new
  def new
    @analysis = Analysis.new
  end

  # GET /analyses/1/edit
  def edit
  end

  # GET /analyses/1/edit_date_values
  def edit_date_values
  end

  # POST /analyses or /analyses.json
  def create
    @analysis = Analysis.new(analysis_params)
    set_analysis_list
    set_analysis_dates
    respond_to do |format|
      if @analysis.save
        format.html { redirect_to analysis_url(@analysis), notice: "Analysis was successfully created." }
        format.json { render :show, status: :created, location: @analysis }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @analysis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /analyses/1 or /analyses/1.json
  def update
    set_analysis_list
    update_analysis_dates(analysis_params["start_date"], analysis_params["end_date"])
    respond_to do |format|
      if @analysis.update(analysis_params)
        format.html { redirect_to analysis_url(@analysis), notice: "Analysis was successfully updated." }
        format.json { render :show, status: :ok, location: @analysis }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @analysis.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /analyses/1/edit_date_values or /analyses/1/edit_date_values.json
  def update_date_values
    values = params[:values]
    lists = params[:lists]
    analysis_dates = params[:analysis_dates]
    date_values = values.each_with_index.map { |value, index| 
      dateValue = DateValue.find_by({list_id: lists[index], analysis_date_id: analysis_dates[index]})
      if dateValue
        dateValue.value = value
      else
        dateValue = DateValue.new({list_id: lists[index], analysis_date_id: analysis_dates[index], value: value})
      end
      dateValue
    }

    AnalysisDate.transaction do
      date_values.each { |date_value| date_value.save }
    end

    respond_to do |format|
      format.html { redirect_to analysis_url(@analysis), notice: "Analysis was successfully updated." }
      format.json { render :show, status: :ok, location: @analysis }
    end
  end

  # POST /analyses/1/sync_data or /analyses/1/sync_data.json
  def sync_data
    if(params[:date])
      date = params[:date].to_date
    else
      date = (Time.now - 3.hours).to_date
    end
    analysis_date = @analysis.analysis_dates.find {|analysis_date| analysis_date.date == date}
    msg = "sync failed"
    if analysis_date
      board = @analysis.board
      user = board.user
      cards_response = HTTParty.get("https://api.trello.com/1/boards/#{board.short_link}/cards?key=#{user.key}&token=#{user.token}")
      cards = JSON.parse(cards_response.body)
      analysis_lists_ids = @analysis.lists.map { |list| list.trello_id }
      date_values = []

      cards.each do |card|
        if analysis_lists_ids.include? card["idList"]
          card_list = @analysis.lists.find { |list| list.trello_id == card["idList"] }
          current_date_value = date_values.find { |date_value| date_value.list == card_list }
          if current_date_value
            date_value = current_date_value
            date_value.value = date_value.value + 1
          else
            date_value = analysis_date.date_values.find { |date_value| date_value.list == card_list }
            if date_value
              date_value.value = 1
              date_values.append(date_value)
            end
          end
        end
      end

      zeros_date_values = analysis_date.date_values.reject {|date_value| date_values.include? date_value}
      zeros_date_values = zeros_date_values.map { |date_value| 
        date_value.value = 0
        date_value
      }
      AnalysisDate.transaction do
        date_values.each { |date_value| date_value.save }
        zeros_date_values.each { |date_value| date_value.save }
      end
      msg = "Data was successfully synced. (#{date})"
    end

    
    respond_to do |format|
      format.html { redirect_to root_path, notice: msg }
      format.json { render :show, status: :ok, location: @analysis }
    end
  end

  # DELETE /analyses/1 or /analyses/1.json
  def destroy
    @analysis.destroy
    respond_to do |format|
      format.html { redirect_to analyses_url, notice: "Analysis was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_analysis
      @analysis = Analysis.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def analysis_params
      params.require(:analysis).permit(:name, :board_id, :pre_planning, :pos_planning, :start_date, :end_date, :status, lists: [])
    end

    def set_analysis_list
      lists = List.where(id: params["lists"])
      @analysis.lists = lists
    end

    def  set_analysis_dates
      dates = (@analysis.start_date...(@analysis.end_date + 1.day)).to_a.map { |date|
        AnalysisDate.new({date: date})
      }
      @analysis.analysis_dates = dates
    end

    def  update_analysis_dates(start_date, end_date)
      start_date = start_date.to_date
      end_date = end_date.to_date
      dates = (start_date...(end_date + 1.day)).to_a
      analysis_dates = @analysis.analysis_dates.map { |analysis_date|
        analysis_date.date
      }
      to_remove = analysis_dates.reject { |analysis_date|
        dates.include? analysis_date
      }
      to_remove_dates = AnalysisDate.where({analysis_id: @analysis.id, date: to_remove})
      to_create = dates.reject { |analysis_date|
        analysis_dates.include? analysis_date
      }
      to_create_dates = to_create.map { |date|
        analysis_date = AnalysisDate.new({date: date})
        analysis_date.analysis = @analysis
        analysis_date
      }
      AnalysisDate.transaction do
        to_remove_dates.destroy_all
        to_create_dates.each { |date| date.save }
      end
    end
end
