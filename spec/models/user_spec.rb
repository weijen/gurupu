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

  describe "#join!" do
    it "should add group" do
      user = FactoryGirl.create(:user)
      group = FactoryGirl.create(:group)

      user.join!(group)
      user.groups.should include(group)
    end
  end

  describe "#quit!" do
    it "should remove group" do
      user = FactoryGirl.create(:user)
      group = FactoryGirl.create(:group)

      user.groups << group
      user.quit!(group)
      user.groups.should_not include(group)
    end
  end

  describe "#is_member_of?" do
    before do
      @user = FactoryGirl.create(:user)
      @group = FactoryGirl.create(:group)
    end

    it "should be true when user is member of this group" do
      @user.join!(@group)

      @user.is_member_of?(@group).should be_true
    end

    it "should be false when user is not a member of this group" do
      @user.is_member_of?(@group).should be_false
    end

  end
end
