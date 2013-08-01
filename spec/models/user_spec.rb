require 'spec_helper'

describe "User" do
  describe ".create_with_omniauth" do
    before do
      @auth = OmniAuth.config.mock_auth[:facebook]
    end

    it "should create user" do
      User.create_with_omniauth(@auth)
      
      User.count.should eql(1)
    end

    it "should return user with errors when data error" do
      @auth["provider"] = nil
      
      user = User.create_with_omniauth(@auth)

      user.should_not be_valid
    end
  end
end
