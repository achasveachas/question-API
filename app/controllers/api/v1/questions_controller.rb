class Api::V1::QuestionsController < ApplicationController

  def index
    @questions = Question.all
    render 'questions/index.json.jbuilder', questions: @questions
  end

  def show
    @question = Question.find_by(id: params[:id])
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
