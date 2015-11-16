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
    @new_question = Question.create(text: params[:text], explanation: params[:explanation], survey_id: params[:survey_id])
    if request.xhr?
      p "QUESTION CREATED-----------------------------------------------------"
      render nothing: true, status: :ok #instead of rendering something, use js to display the questions as a list
    else
      p "ERROR SAVING QUESITON TO DATABASE"
      redirect_to "/surveys/#{@new_question.survey_id}/questions/#{@new_question.id}/edit"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
