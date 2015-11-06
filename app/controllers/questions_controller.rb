class QuestionsController < ApplicationController
  def index
    # @questions = Question.find
  end

  def new
    render "_new_question_partial"
  end

  def create
    @new_question = Question.create(text: params[:text])
    if request.xhr?
      render nothing: true, status: :ok
    else
      redirect_to "/questions/@{question.id}/edit"
    end
  end

  def show

  end

  def edit
  end

  def update
  end

  def destroy
  end
end
