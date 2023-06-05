class AnalysesController < ApplicationController
  before_action :set_analysis, only: %i[ show edit update destroy ]

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
