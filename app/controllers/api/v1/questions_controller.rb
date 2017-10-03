class Api::V1::QuestionsController < ApplicationController
  before_action :authorize
  after_action :increment_counter

  def index
    @questions = Question.private_questions
    render 'questions/index.json.jbuilder', questions: @questions
  end

  def show
    @question = Question.private_questions(params[:id])
    if @question
      render 'questions/show.json.jbuilder', question: @question
    else
      render json: {
        errors: {
          message: "Page not found"
        }
      }, status: 404
    end
  end
end
