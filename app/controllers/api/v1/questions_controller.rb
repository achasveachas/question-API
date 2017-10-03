class Api::V1::QuestionsController < ApplicationController
  before_action :authorize
  after_action :increment_counter

  def index
    @questions = Question.where(private: false)
    render 'questions/index.json.jbuilder', questions: @questions
  end

  def show
    @question = Question.find_by(id: params[:id])
    if @question&.private == false
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
