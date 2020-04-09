require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user=User.new(email: "user@example.com", password: "foobar", password_confirmation: "foobar", first_name: "Example",
       last_name: "User")
  end

  test "should be valid" do
    assert @user.valid?
  end
end
