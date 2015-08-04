class DashboardController < ApplicationController
  def index
    @name = current_user.name
    @matches = current_user.get_matches
  end

  def show_answer
    @answer = Answer.new
    @question = current_user.unanswered_question
  end

  def commit_answer
    res = (params[:commit] == 'yes')
    current_user.answers.create(question_id: params[:answer][:question_id], response: res)
    redirect_to answers_path
  end

  def my_answers
    @answers = Answer.where(user_id: current_user).all
  end
end