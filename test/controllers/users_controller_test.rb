require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  Rails.application.configure do
    routes.default_url_options[:locale] = :en
  end

  setup do
    @user = User.create(name: 'NastyaI', password: '1234', password_confirmation: '1234')
    @user2 = users(:two)
    login
  end

  test 'should get index' do
    get users_url
    assert_response :success
  end

  test 'should get new' do
    get new_user_url
    assert_response :success
  end

  test 'should create user' do
    assert_difference('User.count') do
      post users_url, params: { user: { name: 'user', password: 'secret', password_confirmation: 'secret' } }
    end

    assert_redirected_to User.find_by_name('user')
  end

  test 'should show user' do
    get user_url(@user)
    assert_response :success
  end

  test 'should get edit' do
    get edit_user_url(@user)
    assert_response :success
  end

  test 'should update user' do
    patch user_url(@user), params: { user: { name: @user.name, password: 'secret', password_confirmation: 'secret' } }
    assert_redirected_to @user
  end

  test 'should destroy user' do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to login_path
  end

  test 'should not permit' do
    get edit_user_url(@user2)
    assert_redirected_to @user2
  end
  # chi dc su dung trong cac metod cua class nay thoi
  private

  def login
    get sessions_create_path, params: {
        name: @user.name,
        password: @user.password
    }
  end
end
