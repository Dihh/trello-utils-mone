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
end
