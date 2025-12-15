require "test_helper"

class SaunasControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get saunas_show_url
    assert_response :success
  end
end
