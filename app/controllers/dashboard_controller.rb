class DashboardController < ApplicationController
	def index
		@name = current_user.name
		@matches = User.all.map do |user|
			result = {}
			result[:name] = user[:name]
			both_have = user.answers.select do |answer| 
				current_user.answers.map(&:question_id).include? answer.question_id
			end
			result[:both_have] = both_have
			same = both_have.select do |a|
				current_user.answers.find_by(question_id: a.question_id).response == a.response
			end
			result[:shared] = both_have.size
			if both_have.size != 0
				result[:percent] = same.size / both_have.size * 100
			end
			result
		end
	end

	def show_answer
		@answer = Answer.new
		@question = Question.where.not(
			"exists(
				select 1 from answers 
				where answers.question_id = questions.id
				and answers.user_id = ?
			)", current_user.id
		).order("RANDOM()").first
	end

	def commit_answer
		if params[:commit] == 'yes'
			res = true
		elsif params[:commit] == 'no'
			res = false
		end
		current_user.answers.create(question_id: params[:answer][:question_id], response: res)
		redirect_to answers_path
	end

	def my_answers
		@answers = Answer.where(user_id: current_user).all
	end
end