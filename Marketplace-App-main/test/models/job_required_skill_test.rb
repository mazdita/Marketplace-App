require "test_helper"

class JobRequiredSkillTest < ActiveSupport::TestCase
  def setup
    @skill = JobRequiredSkill.new(job_request_id: 1, skill_id: 1, killer: true) 
  end

  test "should be valid" do 
    assert @skill.valid?
  end

  test "job_request_id should be present" do
    @skill.job_request_id = nil
    assert_not @skill.valid?
  end

  test "skill_id should be present" do
    @skill.skill_id = nil
    assert_not @skill.valid?
  end

  test "killer should be a boolean" do
    @skill.killer = 42
    assert_not @skill.valid?
  end
end
