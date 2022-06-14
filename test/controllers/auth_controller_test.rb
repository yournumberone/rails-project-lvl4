# frozen_string_literal: true

class Web::AuthControllerTest < ActionDispatch::IntegrationTest
  test 'github auth' do
    post auth_request_path('github')
    assert_response :redirect
  end

  test 'create' do
    auth_hash = {
      provider: 'github',
      uid: '123',
      info: {
        email: Faker::Internet.email,
        nickname: Faker::Name.first_name
      },
      credentials: {
        token: '123123'
      }
    }

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash::InfoHash.new(auth_hash)

    get callback_auth_url('github')
    assert_response :redirect

    user = User.find_by!(email: auth_hash[:info][:email].downcase)

    assert user
    assert signed_in?
  end

  test 'new' do
    get new_auth_url

    assert_response :success
  end

  test 'destroy' do
    sign_in(users(:one))
    assert signed_in?

    delete auth_path(current_user.id)

    assert_redirected_to root_path
    assert_not signed_in?
  end
end
