require "test_helper"

class ClockControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get clock_index_url
    assert_response :success
  end
end
