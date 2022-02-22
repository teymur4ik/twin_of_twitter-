require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  Rails.application.configure do
    routes.default_url_options[:locale] = :en
  end

  setup do
    @user = User.create(name: 'NastyaI', password: '1234', password_confirmation: '1234')
  end

  test 'should get new' do
    get sessions_new_url
    assert_response :success
  end

  test 'should get create' do
    login
    assert_redirected_to posts_path
  end

  test 'should get destroy' do
    login
    get sessions_destroy_url
    assert_redirected_to login_path
  end
  
  private

  def login
    get sessions_create_path, params: {
        name: @user.name,
        password: @user.password
    }
  end
end
