class Question < ActiveRecord::Base
  validates :body, :poll_id, presence: true

  belongs_to(
  :poll,
  :class_name => "Poll",
  :foreign_key => :poll_id,
  :primary_key => :id
  )

  has_many(
  :answer_choices,
  :class_name => "AnswerChoice",
  :foreign_key => :question_id,
  :primary_key => :id
  )

  has_many(
  :responses,
  through: :answer_choices,
  source: :responses
  )

  def results
    ############## N+1 query
    # answers = self.answer_choices
    # result = {}
    #
    # answers.each do |ans|
    #   result[ans.body] = ans.responses.length
    # end
    #
    # result
    ############## 2 query
    # answers = self.answer_choices.includes(:responses)
    #
    # result = {}
    #
    # answers.each do |ans|
    #   result[ans.body] = ans.responses.length
    # end
    #
    # result
    #
    ############# SQL Query
    # choices = AnswerChoice.find_by_sql(<<-SQL)
    #   SELECT
    #   a.*, COUNT(*) num_responses
    #   FROM
    #   answer_choices a LEFT OUTER JOIN responses r
    #   ON
    #   (a.id = r.answer_choice_id)
    #   GROUP BY
    #   a.id
    # SQL

    choices = self.answer_choices
    .select("answer_choices.*, COUNT(*)")
    .joins("LEFT OUTER JOIN responses r ON answer_choices.id = r.answer_choice_id")
    .group("answer_choices.id")

    resulting_hash = {}
    choices.each do |choice|
      resulting_hash[choice.body] = choice.num_responses
    end

    resulting_hash
   end
end