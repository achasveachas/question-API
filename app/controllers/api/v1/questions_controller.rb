class Api::V1::QuestionsController < ApplicationController

  def index
    @questions = Question.all
    render 'questions/index.json.jbuilder', questions: @questions
  end

  def show
  end
end
