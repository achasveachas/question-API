require 'rails_helper'

RSpec.describe Answer, type: :model do
    before(:each) do
        @answer = create(:answer)
    end

    it "has a body" do
        expect(@answer.body).not_to be_nil
    end
end