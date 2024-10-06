class ReferenceRangesController < ApplicationController
  before_action :set_reference_range, only: %i[ show edit update destroy ]

  # GET /reference_ranges or /reference_ranges.json
  def index
    @reference_ranges = ReferenceRange.all
  end

  # GET /reference_ranges/1 or /reference_ranges/1.json
  def show
  end

  # GET /reference_ranges/new
  def new
    @reference_range = ReferenceRange.new
  end

  # GET /reference_ranges/1/edit
  def edit
  end

  # POST /reference_ranges or /reference_ranges.json
  def create
    @reference_range = ReferenceRange.new(reference_range_params)

    respond_to do |format|
      if @reference_range.save
        format.html { redirect_to @reference_range, notice: "Reference range was successfully created." }
        format.json { render :show, status: :created, location: @reference_range }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reference_range.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reference_ranges/1 or /reference_ranges/1.json
  def update
    respond_to do |format|
      if @reference_range.update(reference_range_params)
        format.html { redirect_to @reference_range, notice: "Reference range was successfully updated." }
        format.json { render :show, status: :ok, location: @reference_range }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reference_range.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reference_ranges/1 or /reference_ranges/1.json
  def destroy
    @reference_range.destroy!

    respond_to do |format|
      format.html { redirect_to reference_ranges_path, status: :see_other, notice: "Reference range was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reference_range
      @reference_range = ReferenceRange.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reference_range_params
      params.require(:reference_range).permit(:biomarker_id, :min_value, :max_value, :unit, :source, :created_at, :updated_at)
    end
end