require "test_helper"

class JobRequiredSkillsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get job_required_skills_create_url
    assert_response :success
  end
end
