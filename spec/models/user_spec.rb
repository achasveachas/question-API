require 'rails_helper'

RSpec.describe User, type: :model do
    before(:each) do
        @user = create(:user)
    end

    it "has a name" do
        expect(@user.name).not_to be_nil
    end
end