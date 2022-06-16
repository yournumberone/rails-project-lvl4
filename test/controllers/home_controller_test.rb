# frozen_string_literal: true

class Web::HomeControllerTest < ActionDispatch::IntegrationTest
  test 'show home page' do
    get root_url
    assert_response :success
  end
end
