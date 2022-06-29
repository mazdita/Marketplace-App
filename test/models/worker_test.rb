require "test_helper"

class WorkerTest < ActiveSupport::TestCase
  def setup
    @worker = Worker.new(email: "email@email.com", password: "123456", first_name: "james", last_name: "bond", country: "Micronesia", city: "Palikir", available: false, working: true)
  end

  test "should be valid" do 
    assert @worker.valid?
  end

  test "email should be present" do
    @worker.email = ""
    assert_not @worker.valid?
  end

  test "password should be present" do 
    @worker.password = ""
    assert_not @worker.valid?
  end

  test "availiable should be a boolean" do
    @worker.available = "maybe"
    assert_not @worker.valid?
  end

  test "working should be a boolean" do
    @worker.working = "who knows"
    assert_not @worker.valid?
  end
end
