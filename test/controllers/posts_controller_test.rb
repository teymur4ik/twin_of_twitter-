require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  Rails.application.configure do
    routes.default_url_options[:locale] = :en
  end

  setup do
    @user = User.create(name: 'NastyaI', password: '1234', password_confirmation: '1234')
    login
    @post = Post.create(title: 'NastyaI', body: 'Rururu', user_id: @user.id)
    @post2 = posts(:one)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count', 1) do
      post posts_url, params: { post: { body: 'body', title: 'title' } }
    end

    assert_redirected_to Post.find_by_title('title')
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post), params: { post: { body: 'Rururu', title: 'Ilya1312' } }
    assert_redirected_to @post
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_path
  end

  test 'should not permit' do
    get edit_post_url(@post2)
    assert_redirected_to @post2
  end

  private

  def login
    get sessions_create_path, params: {
        name: @user.name,
        password: @user.password
    }
  end
end
