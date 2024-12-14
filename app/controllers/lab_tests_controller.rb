# frozen_string_literal: true

class LabTestsController < ApplicationController
  before_action :set_lab_test, only: %i[show edit update destroy]
  before_action :set_biomarkers, only: %i[new_blood_test create_blood_test]
  before_action :build_lab_test, only: %i[create create_blood_test]

  # GET /lab_tests or /lab_tests.json
  def index
    @recordables = policy_scope(LabTest)
                   .select(:recordable_id, :created_at)
                   .order(:created_at)
                   .group(:recordable_id, :created_at)
    @biomarkers = policy_scope(Biomarker)
                  .includes(:reference_ranges, :lab_tests)
                  .where(lab_tests: { user_id: current_user.id })
  end

  # GET /lab_tests/1 or /lab_tests/1.json
  def show
    authorize @lab_test
  end

  # GET /lab_tests/new
  def new
    @lab_test = LabTest.new
    # authorize @lab_test
  end

  # GET /lab_tests/1/edit
  def edit
    authorize @lab_test
  end

  # POST /lab_tests or /lab_tests.json
  def create
    # authorize @lab_test

    respond_to do |format|
      if @lab_test.save
        format.html { redirect_to @lab_test, notice: t('.success') }
        format.json { render :show, status: :created, location: @lab_test }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lab_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lab_tests/1 or /lab_tests/1.json
  def update
    authorize @lab_test

    respond_to do |format|
      if @lab_test.update(lab_test_params)
        format.html { redirect_to @lab_test, notice: t('.success') }
        format.json { render :show, status: :ok, location: @lab_test }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lab_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lab_tests/1 or /lab_tests/1.json
  def destroy
    authorize @lab_test
    @lab_test.destroy!

    respond_to do |format|
      if request.referer == lab_test_url
        format.html { redirect_to lab_tests_path, status: :see_other, notice: t('.success') }
      else
        format.html do
          redirect_back_or_to lab_tests_path, status: :see_other, notice: t('.success')
        end
      end
      format.json { head :no_content }
    end
  end

  def new_blood_test
    @lab_test = LabTest.new
    @biomarkers = Biomarker.all
    authorize @lab_test
  end

  def create_blood_test
    authorize @lab_test

    ActiveRecord::Base.transaction do
      @health_record = HealthRecord.new(
        user: current_user.full_access_roles_can? ? User.find(params[:user_id]) : current_user,
        notes: lab_test_params[:notes]
      )

      @lab_test.assign_attributes(blood_test_params)
      @lab_test.recordable = @health_record
      @lab_test.user = @health_record.user
      @lab_test.notes = lab_test_params[:notes]

      if @lab_test.valid? && @health_record.valid?
        @health_record.save!
        @lab_test.save!
        flash[:notice] = 'Blood test was successfully created.'
        redirect_to @health_record and return
      else
        @biomarkers = Biomarker.all

        if @lab_test.biomarker_id.present?
          @selected_biomarker = Biomarker.find(@lab_test.biomarker_id)
          @reference_ranges = @selected_biomarker.reference_ranges
        end

        render :new_blood_test, status: :unprocessable_entity and return
      end
    rescue StandardError => e
      @biomarkers = Biomarker.all
      flash.now[:alert] = 'An error occurred while saving the blood test.'
      render :new_blood_test, status: :unprocessable_entity and return
    ensure
      raise ActiveRecord::Rollback unless @lab_test.persisted?
    end
  end

  private

  def set_biomarkers
    @biomarkers = Biomarker.all
  end

  def set_lab_test
    @lab_test = LabTest.find(params[:id])
  end

  def build_lab_test
    @lab_test = current_user.lab_tests.build
  end

  # Only allow a list of trusted parameters through.
  def lab_test_params
    params
      .require(:lab_test)
      .permit(:user_id, :biomarker_id, :value, :unit, :reference_range_id, :recordable_type, :recordable_id, :notes,
              :created_at, :updated_at)
  end

  def blood_test_params
    params.require(:lab_test).permit(
      :biomarker_id,
      :value,
      :unit,
      :reference_range_id,
      :notes
    )
  end
end
