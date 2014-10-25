class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id,
    presence: true
  validate :respondent_has_not_already_answered_question,
           :creator_cannot_answer_own_question

  # Do we need question_id?

  def sibling_responses
    if persisted?
      question.responses.where("responses.id != ?", self.id)
    else
      question.responses
    end
  end



  belongs_to(
  :respondent,
  :class_name => "User",
  :foreign_key => :user_id,
  :primary_key => :id
  )

  belongs_to(
  :answer_choice,
  class_name: "AnswerChoice",
  foreign_key: :answer_choice_id,
  primary_key: :id
  )

  has_one(
  :question,
  through: :answer_choice,
  source: :question
  )

  private
  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(user_id: self.user_id)
      errors[:respondent_answered] << "Respondent has already answered"
    end
  end
  def creator_cannot_answer_own_question
    #answer_choice -> question -> poll -> author
    if self.answer_choice.question.poll.author_id == user_id
      errors[:creator_answered] << "Creator cannot answer own question"
    end
  end

end