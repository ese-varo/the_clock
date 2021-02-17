require "test_helper"

class StopwatchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stopwatches_index_url
    assert_response :success
  end
end
