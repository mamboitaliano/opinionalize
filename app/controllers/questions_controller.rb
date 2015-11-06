class QuestionsController < ApplicationController
  def index
    # @questions = Question.find
  end

  def new
    p "NEW QUESTION ROUTE IS BEING HIT----------------------------------------"
    p params
    p "-----------------------------------------------------------------------"
    @current_survey = Survey.find(params[:survey_id])
    render "_new_question_partial", layout: false
  end

  def show
  end

  def create
    @new_question = Question.create(text: params[:text])
    if request.xhr?
      render nothing: true, status: :ok #instead of rendering something, use js to display the questions as a list
    else
      redirect_to "/questions/@{question.id}/edit"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
