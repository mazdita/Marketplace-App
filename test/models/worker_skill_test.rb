require "test_helper"

class WorkerSkillTest < ActiveSupport::TestCase
  def setup
    @skill = WorkerSkill.new(worker_id: 1, skill_id: 1)
  end

  test "should be valid" do
    assert @skill.valid?
  end

  test "worker_id must be present" do
    @skill.worker_id = nil
    assert_not @skill.valid?
  end

  test "skill_id must be present" do
    @skill.skill_id = nil
    assert_not @skill.valid?
  end
end
