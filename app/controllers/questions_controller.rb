class QuestionsController < ApplicationController
  def index
    # @questions = Question.find
  end

  def new
    p "NEW QUESTION ROUTE IS BEING HIT | params = ----------------------------"
    p params
    p "-----------------------------------------------------------------------"
    @current_survey = Survey.find(params[:survey_id])
    render "_new_question_partial", layout: false
  end

  def show
  end

  def create
    @new_question = Question.create(text: params[:text], explanation: params[:explanation], survey_id: params[:survey_id])
    p "Newly created question-- -- -- -- -- -- --"
    p @new_question
    if request.xhr?
      p "-- -- -- -- -- -- -- >> QUESTION CREATED"
      render "_question_partial", layout: false, status: :ok
    else
      p "ERROR SAVING QUESITON TO DATABASE"
      redirect_to "/surveys/#{@new_question.survey_id}/questions/#{@new_question.id}/edit"
    end
  end

  def edit
    p "EDIT QUESTION ROUTE IS BEING HIT | params = ----------------------------"
    p params
    p "------------------------------------------------------------------------"
    @current_question = Question.find(params[:question_id])
    render "_edit_question_partial"
  end

  def update
  end

  def destroy
  end
end
