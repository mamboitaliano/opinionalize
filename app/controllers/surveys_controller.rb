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
    current_user.surveys << @survey = Survey.create(title: params[:title])
    redirect_to "/surveys/#{@survey.id}/edit"
  end

  def remit
    @current_survey = Survey.find(params[:id])

    # very clever, thanks harvey!
    params.each do |k, v|
      unless k.to_i == 0
        question = Question.find_by(id: k)
        question.responses << Response.create!(text: v)
      else
        "You're a butterface!"
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
    if request.xhr?
      render 'partials/_question'
    else
      redirect_to "/surveys/#{@survey.id}/edit"
    end
  end

  def delete

  end

  def delete_question
    question = Question.find_by(id: params[:question_id])
    survey = Survey.find_by(id: params[:survey_id])
    Question.destroy(question.id)
    survey.save
    if request.xhr?
      render nothing: true, status: :ok
    else
      redirect_to "/surveys/#{survey.id}/edit"
    end
  end

end
