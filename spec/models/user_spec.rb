require 'rails_helper'

RSpec.describe User, type: :model do
    before(:each) do
        @user = create(:user)
    end

    it "has a name" do
        expect(@user.name).not_to be_nil
    end

    describe "relationships" do
        it "has many questions" do
            @user.questions.create(title: FFaker::HipsterIpsum.sentence.gsub(/\.$/, "?"), private: false)

            expect(@user.questions.first).to be_a(Question)
        end

        it "has many answers" do
            question = create(:question)
            create(:answer, user_id: @user.id, question_id: question.id)
            expect(@user.answers.first).to be_a(Answer)
        end
    end
end