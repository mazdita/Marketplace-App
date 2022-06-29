class Candidacy < ApplicationRecord
  validates :worker_id, :job_request_id, :status, :start_date, presence: true
  validates :status, acceptance: { accept: ["validating","approved","archived"]}

  belongs_to :worker
  belongs_to :job_request

  enum status: {
    validating: 0,
    approved: 1,
    archived: 2
  }

  def update_status( status )
    self.status = status
    update_columns(status: status)
  end
end
