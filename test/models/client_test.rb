require "test_helper"

class ClientTest < ActiveSupport::TestCase
  def setup
    @client = Client.new(name: "client",  address:"street", password: "123456", email:"email@email.com")
  end

  test "should be valid" do
    assert @client.valid?
  end

  test "name should be present" do
    @client.name = ""
    assert_not @client.valid?
  end

  test "address should be present" do
    @client.address = ""
    assert_not @client.valid?
  end

  test "email should be present" do
    @client.email = ""
    assert_not @client.valid?
  end

  test "password should be present" do
    @client.password = ""
    assert_not @client.valid?
  end
end
