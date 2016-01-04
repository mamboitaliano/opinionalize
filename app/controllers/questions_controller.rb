class QuestionsController < ApplicationController
  def index
    # @questions = Question.find
  end

  def new
    p "NEW QUESTION ROUTE IS BEING HIT | params = -----------------------------"
    p params
    p "------------------------------------------------------------------------"
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
    @current_question = Question.find(params[:id])
    render "_edit_question_partial", layout: false
  end

  def update
    p "UPDATE QUESTION ROUTE HIT | params = -----------------------------------"
    p params
    p "------------------------------------------------------------------------"

    @current_question = Question.find(params[:id])
    p "current questions is #{@current_question.id}"
    p "the response type is #{params[:resp_type]}"
    
    response_type = params[:resp_type]
    case response_type
    when "textinput"
      @current_question.resp_type = 0
    when "multichoice"
      @current_question.resp_type = 1
    when "chkboxes"
      @current_question.resp_type = 2
    else
      p "invalid parameter value"   # be sure to use this else clause to prevent injection
    end
        
    p @current_question
    @current_question.save
    # TODO: write logic to write possible answers to database

    if request.xhr?
      p "-- -- -- -- -- -- -- >> request is xhr"
    else
      p "-- -- -- -- -- -- -- >> request is not xhr"
    end
  end

  def destroy
  end
end
