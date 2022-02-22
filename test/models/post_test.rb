require "test_helper"

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user = User.create(name: 'NastyaI', password: '1234', password_confirmation: '1234')
    @post = Post.create(user_id: @user.id, title: 'NastyaI', body: 'Rururu')
  end

  test 'valid really post' do
    assert @post.valid?
  end

  test 'invalid without user_id' do
    @post.user_id = nil
    refute @post.valid?
    assert_not_nil @post.errors[:user_id]
  end

  test 'invalid without title' do
    @post.title = nil
    refute @post.valid?
    assert_not_nil @post.errors[:title]
  end

  test 'valid really without body' do
    @post.body = nil
    assert @post.valid?
  end
end
