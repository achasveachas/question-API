require 'rails_helper'

RSpec.describe Answer, type: :model do
    before(:each) do
        @answer = create(:answer)
    end

    it "has a body" do
        expect(@answer.body).not_to be_nil
    end

    describe "relationships" do
        it "belongs to an answerer" do

            expect(@answer.answerer).to be_a(User)
        end

        it "belongs to a question" do

            expect(@answer.question).to be_a(Question)
        end
    end
end