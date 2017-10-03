require 'rails_helper'

RSpec.describe Question, type: :model do
    before(:each) do
        @question = create(:question)
    end

    it "has a title" do
        expect(@question.title).not_to be_nil
    end
end