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
    p "UPDATE QUESTION ROUTE HIT ----------------------------------------------"
    @current_question = Question.find(params[:id])
    # TODO: wite logic to write reponse type to database
    # maybe export this out to a helper method to improve legibility?
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
    # TODO: write logic to write possible answers to database
    temp_array = []
    params.each do |k, v|
      if (k.include? "answerchoice") && (v != "")
        temp_array << v
      end
    end

    @current_question.resp_choices = temp_array.join(",")
    @current_question.save

    if request.xhr?
      p "-- -- -- -- -- -- -- >> request is xhr"
    else
      p "-- -- -- -- -- -- -- >> request is not xhr"
    end
  end

  def destroy
  end
end
