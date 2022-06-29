require "test_helper"

class JobRequestTest < ActiveSupport::TestCase
  def setup
    @job = JobRequest.new(client_id: 1, start_date: Time.zone.now, end_date: Time.zone.now + 1.year, job_function: "work", address: "somewhere", vacancies_count: 21, details: "somenthing", monthly_salary: 21)
  end

  test "should be valid" do
    assert @job.valid?
  end

  test "name should be present" do
    @job.name = ""
    assert_not @job.valid?
  end

  test "start_date should be present" do
    @job.start_date = nil
    assert_not @job.valid?
  end

  test "end_date should be present" do
    @job.end_date = nil
    assert_not @job.valid?
  end

  test "job_function should be present" do
    @job.job_function = ""
    assert_not @job.valid?
  end

  test "address should be present" do
    @job.address = ""
    assert_not @job.valid?
  end

  test "vacancies_count should be present" do
    @job.vacancies_count = nil
    assert_not @job.valid?
  end

  test "details should be present" do
    @job.details = ""
    assert_not @job.valid?
  end

  test "monthly_salary should be present" do
    @job.monthly_salary = nil
    assert_not @job.valid?
  end

  test "vacancies_count is a number" do
    @job.vacancies_count = "hello"
    assert_not @job.valid?
  end

  test "total_vacancies is a number" do
    @job.total_vacancies = "hello"
    assert_not @job.valid?
  end

  test "monthly_salary is a number" do
    @job.monthly_salary = "hello"
    assert_not @job.valid?
  end

  test "market_value is a number" do
    @job.market_value = "hello"
    assert_not @job.valid?
  end

  test "start date must be before end date" do
    @job.start_date = Time.zone.now + 1.year
    @job.start_date = Time.zone.now
    assert_not @job.valid?
  end
end
