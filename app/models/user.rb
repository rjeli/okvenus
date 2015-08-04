class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :answers, dependent: :destroy
  has_many :questions, through: :answers

  def get_matches
    User.where.not(id: self.id).all.map do |user|
      user = UserDecorator.new(user)
      result = {}
      result[:name] = user[:name]
      both_have = user.answers.select do |answer| 
        self.answers.map(&:question_id).include? answer.question_id
      end
      result[:both_have] = both_have
      same = both_have.select do |a|
        self.answers.find_by(question_id: a.question_id).response == a.response
      end
      result[:shared] = both_have.size
      if both_have.size != 0
        result[:percent] = same.size.to_f / both_have.size.to_f * 100
      end
      result
    end
  end

  def unanswered_question
    Question.where.not(
      "exists(
        select 1 from answers 
        where answers.question_id = questions.id
        and answers.user_id = ?
      )", self.id
    ).order("RANDOM()").first
  end
end
