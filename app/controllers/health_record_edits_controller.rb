class HealthRecordEditsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_health_record

  def show
    # Show edit form
  end

  def update
    if @health_record.update(health_record_params)
      redirect_to health_record_path(@health_record), notice: 'Health record was successfully updated.'
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_health_record
    @health_record = HealthRecord.find(params[:health_record_id])
  end

  def health_record_params
    params.require(:health_record).permit(:pdf_file, :notes, :source)
  end
end 