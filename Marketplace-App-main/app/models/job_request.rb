class JobRequest < ApplicationRecord
  validates :client_id, :start_date, :end_date,:job_function, :address, :vacancies_count, :details, :monthly_salary,presence: true
  validates :vacancies_count, :total_vacancies, :monthly_salary, :market_value, numericality: true
  validate :start_must_be_before_end_time
  
  has_many :candidacies, dependent: :destroy
  has_many :workers, through: :candidacies
  has_many :job_required_skills, dependent: :destroy
  has_many :skills, through: :job_required_skills
  belongs_to :client

  # attr_accessor :skill_array
  attr_accessor :fill_rate
  attr_accessor :user_fit_score

  def update_vacancies
    self.vacancies_count -= 1
    update_columns(vacancies_count: vacancies_count)
  end

  # def create_related_skills
  #   self.skill_array.each do |skill_id|
  #     JobRequiredSkill.create(job_request_id: self.id, skill_id: skill_id, killer: false)
  #   end
  # end 

  # def update_current_skills_array
  #   @current_skills_array = []
    
  #   JobRequiredSkill.where(job_request_id: self.id).each do |skill|
  #     @current_skills_array << skill.skill
  #   end

  #   self.skill_array = @current_skills_array
  # end

  # def update_related_skills(params)
  #   @skills = params[:job_request][:skills_array]
  #   JobRequiredSkill.where(job_request_id: self.id).destroy_all
  #   @skills.each do |skill_id| 
  #     JobRequiredSkill.create(job_request_id: self.id, skill_id: skill_id, killer: false)
  #   end
  # end

  def calculate_market_value
    self.market_value = self.vacancies_count * self.monthly_salary
  end

  def fill_rate
    return (self.vacancies_count+1) / (self.total_vacancies+1)*100 
  end

  def calculate_user_fit_score(worker)
    self.user_fit_score = (worker.skills & self.skills).count
  end

  def start_must_be_before_end_time
    errors.add(:start_date, "must be before end time") unless
        start_date < end_date
  end 
end
