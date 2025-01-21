class Pdf < ApplicationRecord
  include SterlingAccurisStructure
  
  belongs_to :health_record
  belongs_to :user
  
  has_one_attached :file
  
  validates :file, presence: true, on: :create
  validates :scan_method, presence: true, inclusion: { in: ['sterling_accuris', 'umc_pathology'] }, on: :create
  
  attribute :scan_method, :string
  attribute :status, :string, default: 'pending'
  attribute :processed_data, :json, default: {}
  attribute :notes, :text
  
  before_save :ensure_processed_data_json

  enum status: {
    pending: 'pending',
    processing: 'processing',
    completed: 'completed',
    failed: 'failed'
  }, _default: 'pending'

  def format_name
    case scan_method
    when 'sterling_accuris'
      'Sterling Accuris'
    when 'umc_pathology'
      'University Medical Center, Dept. of Pathology'
    else
      'Not specified'
    end
  end

  private

  def ensure_processed_data_json
    # Ensure processed_data is always a hash/json
    self.processed_data = {} if processed_data.nil?
    
    # Convert processed_data to json if it's not already
    unless processed_data.is_a?(Hash)
      self.processed_data = JSON.parse(processed_data.to_s) rescue {}
    end
  end
end 