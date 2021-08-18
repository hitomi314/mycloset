require 'test_helper'

class SaerchControllerTest < ActionDispatch::IntegrationTest
  test 'should get saerch' do
    get saerch_saerch_url
    assert_response :success
  end
end
