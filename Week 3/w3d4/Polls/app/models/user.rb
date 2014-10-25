require_relative 'poll'
require_relative 'response'
class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  has_many(
  :authored_polls,
  :class_name => "Poll",
  :foreign_key => :author_id,
  :primary_key => :id
  )

  has_many(
  :responses,
  :class_name => "Response",
  :foreign_key => :user_id,
  :primary_key => :id
  )



  def completed_polls

    # query = <<-SQL
   #      SELECT DISTINCT
   #        p.*
   #      FROM
   #        polls p
   #      JOIN
   #        questions q ON p.id = q.poll_id
   #      JOIN
   #        answer_choices a ON q.id = a.question_id
   #      LEFT OUTER JOIN
   #        (
   #        SELECT
   #        *
   #        FROM
   #        responses
   #        WHERE
   #        user_id = ?
   #        ) r
   #      ON a.id = r.answer_choice_id
   #      GROUP BY
   #        p.id
   #      HAVING
   #        COUNT(r.id) = COUNT(q.id)
   #      SQL
   #
   #  responses = Poll.find_by_sql([query, self.id])


    Poll.select("polls.*, COUNT(r.id) AS r_count, COUNT(DISTINCT questions.id) AS q_count")
      .joins(:questions => :answer_choices)
      .joins("LEFT OUTER JOIN (
          SELECT
          *
          FROM
          responses
          WHERE
          user_id = #{self.id}
          )  r ON answer_choices.id = r.answer_choice_id")
      .group("polls.id")
      .having("COUNT(r.id) = COUNT(DISTINCT questions.id)")


    # Poll -> Question -> AnswerChoice -> Response -> User



  end


end
