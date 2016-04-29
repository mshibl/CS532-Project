require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    # FactoryGirl.create(:user).should be_valid
    expect(FactoryGirl.create(:user)).to be_valid
  end

  it "is invalid without a twitter ID" do
   expect(FactoryGirl.build(:user, uid: nil)).to_not be_valid
   end

end
