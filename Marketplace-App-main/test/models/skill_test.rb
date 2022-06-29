require "test_helper"

class SkillTest < ActiveSupport::TestCase
  def setup
    @skill = Skill.new(name: "Jumping")
  end

  test "should be valid" do
    assert @skill.valid?
  end

  test "name should be present" do
    @skill.name = ""
    assert_not @skill.valid?
  end
end
