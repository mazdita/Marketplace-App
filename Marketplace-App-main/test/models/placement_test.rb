require "test_helper"

class PlacementTest < ActiveSupport::TestCase
  def setup
    @placement = Placement.new(candidacy_id: 1, worker_id: 1, client_id: 1, start_date: Time.zone.now, monthly_salary: 1234, end_date: Time.zone.now + 1.year)
  end

  test "should be valid" do
    assert @placement.valid?
  end

  test "candidacy_id should be present" do 
    @placement.candidacy_id = nil
    assert_not @placement.valid?
  end

  test "worker_id should be present" do 
    @placement.worker_id = nil
    assert_not @placement.valid?
  end

  test "client_id should be present" do 
    @placement.client_id = nil
    assert_not @placement.valid?
  end
  
  test "start_date should be present" do 
    @placement.start_date = nil
    assert_not @placement.valid?
  end
  
  test "end_date should be present" do 
    @placement.end_date = nil
    assert_not @placement.valid?
  end

  test "monthly_salary should be present" do 
    @placement.monthly_salary = nil
    assert_not @placement.valid?
  end

  test "monthly_salary should be a number" do 
    @placement.monthly_salary = "not a number"
    assert_not @placement.valid?
  end

  test "start date should be earlier than end date" do 
    @placement.start_date = Time.zone.now + 1.year
    @placement.end_date = Time.zone.now
    assert_not @placement.valid?
  end
end
