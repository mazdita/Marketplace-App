class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email,presence: true

  has_many :job_requests, dependent: :destroy
  has_many :placements, dependent: :destroy
  has_many :workers, through: :placements

  def self.to_csv
    attributes = %w(name email address job_requests)
    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << user.attributes.values_at(*attributes)
      end
    end
  end

  def employees
    self.workers
  end
end
