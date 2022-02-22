require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user = User.create(name: 'NastyaI', password: '1234', password_confirmation: '1234')
  end

  test 'valid user' do
    assert @user.valid?
  end

  test 'invalid without name' do
    @user.name = nil
    refute @user.valid?
    assert_not_nil @user.errors[:name]
  end

  test 'invalid without password' do
    @user.password = nil
    refute @user.valid?
    assert_not_nil @user.errors[:password]
  end

  test 'invalid without password_confirmation' do
    @user.password_confirmation = nil
    assert_not_nil @user.errors[:password_confirmation]
  end
end
