class Placement < ApplicationRecord
  validates :candidacy_id, :worker_id, :client_id, :start_date, :end_date ,:monthly_salary, presence: true
  validates :monthly_salary, numericality: true
  validate :start_must_be_before_end_time
  
  belongs_to :candidacy
  belongs_to :worker
  belongs_to :client
  has_one :job_request, through: :candidacy
  
  private

  def start_must_be_before_end_time
    errors.add(:start_date, "must be before end time") unless
        start_date < end_date
  end 
end
