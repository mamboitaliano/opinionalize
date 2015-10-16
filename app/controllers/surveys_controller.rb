class SurveysController < ApplicationController

  def index
    # list all surveys
    @all_surveys = Survey.all
    render 'index'
  end

  def new
    render 'new'
  end

  def show
    @current_survey = Survey.find(params[:id])
    render 'show'
  end

  def create
    p params
    current_user.surveys << @survey = Survey.create(title: params[:title], description: params[:description], is_public: params[:is_public])
    redirect_to "/surveys/#{@survey.id}/edit"
  end

  def remit
    @current_survey = Survey.find(params[:id])
    params.each do |k, v|
      unless k.to_i == 0
        question = Question.find_by(id: k)
        question.responses << Response.create!(text: v)
      else
        "Error writing to database"
        # erb :'surveys/survey_show'
      end
    end
    redirect_to "/surveys/#{@current_survey.id}/results"
  end

  def results
    @current_survey = Survey.find(params[:id])
    render 'results'
  end

  def editform
    @survey = Survey.find(params[:id])
    render 'edit_survey'
  end

  def edit
    @survey=Survey.find(params[:id])
    @survey.questions << @question = Question.create(text: params[:text])
    @last_question = @survey.questions.last
    if request.xhr?
      render 'surveys/_question_partial', layout: false
    else
      redirect_to "/surveys/#{@survey.id}/edit"
    end
  end

  def delete

  end

  def delete_question
    question = Question.find_by(id: params[:question_id])
    survey = Survey.find_by(id: params[:survey_id])
    p "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    # p question.id.to_i
    # p question.text
    qId = params[:question_id].to_i
    p qId
    p "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    Question.delete(qId)
    survey.save
    if request.xhr?
      render nothing: true, status: :ok
    else
      p "REDIRECTING ---------------------------"
      redirect_to "/surveys/#{survey.id}/edit"
    end
  end

end
