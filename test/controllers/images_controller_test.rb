require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get picture:string" do
    get images_picture:string_url
    assert_response :success
  end

end
