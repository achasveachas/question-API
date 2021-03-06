require 'rails_helper'

RSpec.describe Question, type: :model do
    before(:each) do
        @question = create(:question)
    end

    it "has a title" do
        expect(@question.title).not_to be_nil
    end

    it "defaults to public but can be set private" do
        expect(@question.private).to be_falsey

        @question.update_attributes(private: true)
        expect(@question.private).to be(true)
    end

    describe "relationships" do
        it "belongs to an asker" do

            expect(@question.asker).to be_a(User)
        end

        it "has many answers" do
            create(:user)
            User.last.answers.create(body: FFaker::HipsterIpsum.sentence, question_id: @question.id)
            expect(@question.answers.first).to be_a(Answer)
        end
    end
end