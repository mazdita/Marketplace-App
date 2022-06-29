require "test_helper"

class CandidacyTest < ActiveSupport::TestCase
  def setup
    @candidacy = Candidacy.new(status: "validating", start_date: Time.zone.now, job_request_id: 1, worker_id: 1)
  end

  test "should be valid" do
    assert @candidacy.valid?
  end

  test "worker id should be present" do
    @candidacy.worker_id = ""
    assert_not @candidacy.valid?
  end

  test "job id should be present" do
    @candidacy.job_request_id = ""
    assert_not @candidacy.valid?
  end

  test "status should be present" do
    @candidacy.status = ""
    assert_not @candidacy.valid?
  end
  
  test "status value should be accepted" do
    @candidacy.status = "somenthing"
    assert_not @candidacy.valid?
  end
end
