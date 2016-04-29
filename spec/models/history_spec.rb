require 'rails_helper'

describe History do
  before(:each) do
    @user_history = History.create!({user_id: 1, followers_count: 0})
  end
  context "when valid" do
    it "reflects a change in followers when updated" do
      @user_history.followers_count = 1
      expect(@user_history.followers_count).to eq(1)
    end
  end

  context "when invalid" do
    it "rejects a nil followers_count value" do
      @user_history.followers_count = nil
      expect(@user_history).to_not be_valid
    end
  end
end


