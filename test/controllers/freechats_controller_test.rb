require 'test_helper'

class FreechatsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get freechats_index_url
    assert_response :success
  end

  test "should get new" do
    get freechats_new_url
    assert_response :success
  end

  test "should get show" do
    get freechats_show_url
    assert_response :success
  end

end
