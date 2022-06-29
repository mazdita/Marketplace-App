class Worker < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :skill_array
  attr_accessor :job_fit_score
  
  validates :email, presence: true
  validates :available, :working, inclusion: {in: [true, false]}
  
  has_many :worker_skills, dependent: :destroy
  has_many :skills, through: :worker_skills
  has_many :candidacies, dependent: :destroy
  has_one :placement
  has_one :job_request, through: :placement

  def change_working_status
    self.toggle!(:working)
  end

  def change_availiability
    self.toggle!(:available)
  end

  def calculate_job_fit_score(job)
    self.job_fit_score = (job.skills & self.skills).count
  end

  def already_applied(params)
    !Candidacy.find_by(worker_id: self.id, job_request_id: params[:id]).nil?
  end

  def archive_candidacies
    self.candidacies.each do |candidacy|
      unless candidacy.status == "approved"
        candidacy.update_status(2)
      end
    end
  end

  def employer
    @employer = Client.joins(:placements).where(placements: {worker_id: self.id}).first
  end

  def current_job
    if self.placement
      self.placement.job_request.job_function
    end
  end
end
