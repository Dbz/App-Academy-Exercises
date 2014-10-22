require 'singleton'
require 'sqlite3'
require 'debugger'

class QuestionsDatabase < SQLite3::Database
  include Singleton
  def initialize
    super("questions.db")
    # Typically each row is returned as an array of values; it's more
    # convenient for us if we receive hashes indexed by column name.
    self.results_as_hash = true

    # Typically all the data is returned as strings and not parsed
    # into the appropriate type.
    self.type_translation = true
  end
end

class Database
  # attr_accessor :id
  def self.all
    # execute a SELECT; result in an `Array` of `Hash`es, each
    # represents a single row.
    results = QuestionsDatabase.instance.execute("SELECT * FROM #{class_name}")
    #debugger
    results.map { |result| new(result) }
  end
  
  def self.find_by_id(id)
    results = QuestionsDatabase.instance.get_first_row(
    "SELECT
        *
      FROM
      #{class_name}
      WHERE
      #{class_id} = #{id}")

    new(results)
  end
end

class User < Database
  attr_accessor :id, :fname, :lname
  def self.class_name
    "users"
  end
  def self.class_id
    "user_id"
  end
  
  def save
    if @id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
        INSERT INTO
          users
          (fname, lname)
        VALUES
          (? , ?)

      SQL
      
    else
      QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
        UPDATE
          users
          (fname, lname)
        VALUES
          (? , ?)

      SQL
    end
    @id = QuestionsDatabase.instance.last_insert_row_id
  end
  
  def self.find_by_name(fname, lname)
    result = QuestionsDatabase.instance.get_first_row(<<-SQL, fname, lname)
          SELECT
            *
          FROM
            users
          WHERE
            fname = ?
          AND
            lname = ?
    SQL

    new(result)
  end
  
  def average_karma
    result = QuestionsDatabase.instance.get_first_row(<<-SQL, @id) 
      SELECT 
        CAST(COUNT(ql.user_id) AS FLOAT) / COUNT(DISTINCT q.question_id)
      FROM 
        question_likes ql 
      JOIN 
        questions q 
      ON 
        (ql.question_id = q.question_id)
      WHERE q.user_id = @id
    SQL
    result.values.first
  end
  
  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end
  
  def followed_questions
    QuestionFollower.followed_questions_for_user_id(@id)
  end
  
  def authored_questions
    results = QuestionsDatabase.instance.execute(<<-SQL, @id)
          SELECT
            *
          FROM
            questions
          WHERE
            user_id = ?
    SQL

    results.map { |result| Question.new(result) }
  end
  
  def authored_replies
    Reply.find_by_user_id(@id)
  end
  
  def initialize(options = {})
    #debugger
     @id = options['user_id']
     @fname = options['fname']
     @lname = options['lname']
   end
end

class Question < Database
  attr_accessor :id, :title, :body, :user_id
  
  def self.class_name
    "questions"
  end
  
  def self.class_id
    "question_id"
  end
  
  # def save
  #   if @id.nil?
  #     QuestionsDatabase.instance.execute(<<-SQL
  #
  #     SQL
  #   end
  # end
  
  def author
    User.find_by_id(@user_id)
  end
  
  def replies
    Reply.find_by_question_id(@id)
  end
  
  def self.find_by_author_id(author_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, author_id)
          SELECT
            *
          FROM
            questions
          WHERE
            user_id = ?
    SQL

    results.map { |result| Reply.new(result) }
  end
  
  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end
  
  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end
  
  def likers
    QuestionLike.likers_for_question_id(@id)
  end
  
  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end
  
  def followers
    QuestionFollower.followers_for_question_id(@id)
  end
    
  
  def initialize(options = {})
    @id = options['question_id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end
end

class QuestionFollower < Database
  attr_accessor :id, :question_id, :user_id
  
  def self.class_name
    "questionfollowers"
  end
  
  def self.class_id
    "questionfollower_id"
  end
  
  def self.followers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
          SELECT
            u.user_id, u.fname, u.lname
          FROM
            question_followers q JOIN users u ON (q.user_id = u.user_id)
          WHERE
            q.question_id = ?
    SQL

    results.map { |result| User.new(result) }
  end
  
  def self.followed_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
          SELECT
            u.question_id, u.title, u.body, u.user_id
          FROM
            question_followers q JOIN questions u ON (q.question_id = u.question_id)
          WHERE
            q.user_id = ?
    SQL

    results.map { |result| Question.new(result) }
  end
  
  def self.most_followed_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        qf.question_id, q.title, q.body, q.user_id
      FROM
        question_followers qf
      JOIN
        questions q
      ON
        (qf.question_id = q.question_id)
      GROUP BY
        qf.question_id
      ORDER BY
        COUNT(qf.question_id) DESC
    SQL

    results.map { |result| Question.new(result) }.take(n)
  end
  
  def initialize(options = {})
    @id = options['questionfollower_id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end
end

class Reply < Database
  attr_accessor :id, :question_id, :parent_id, :user_id, :body
  
  def self.class_name
    "replies"
  end
  
  def self.class_id
    "reply_id"
  end
  
  # def save
  #   if @id.nil?
  #     QuestionsDatabase.instance.execute(<<-SQL
  #
  #     SQL
  #   end
  # end
  
  def self.find_by_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
          SELECT
            *
          FROM
            replies
          WHERE
            question_id = ?
    SQL

    results.map { |result| Reply.new(result) }
  end
  
  def self.find_by_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
          SELECT
            *
          FROM
            replies
          WHERE
            user_id = ?
    SQL

    results.map { |result| Reply.new(result) }
  end
  
  def author
    result = QuestionsDatabase.instance.get_first_row(<<-SQL, @user_id)
          SELECT
            *
          FROM
            users
          WHERE
            user_id = ?
    SQL

    User.new(result)
  end
  
  def question
    result = QuestionsDatabase.instance.get_first_row(<<-SQL, @question_id)
          SELECT
            *
          FROM
            questions
          WHERE
            question_id = ?
    SQL

    Question.new(result)
  end
  
  def parent_reply
    result = QuestionsDatabase.instance.get_first_row(<<-SQL, @parent_id)
          SELECT
            *
          FROM
            replies
          WHERE
            reply_id = ?
    SQL

    Reply.new(result)
  end
  
  def child_replies
    results = QuestionsDatabase.instance.execute(<<-SQL, @id)
          SELECT
            *
          FROM
            replies
          WHERE
            parent_id = ?
    SQL

    results.map { |result| Reply.new(result) }
  end
  
  def initialize(options = {})
    @id = options['reply_id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
    @user_id = options['user_id']
    @body = options['body']
  end
end

class QuestionLike < Database
  attr_accessor :id, :question_id, :user_id, :body
  
  def self.class_name
    "questionlikes"
  end
  
  def self.class_id
    "questionlike_id"
  end
  
  def self.likers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
          SELECT
          u.user_id, u.fname, u.lname
          FROM
            users u
          JOIN
            question_likes q ON (u.user_id = q.user_id)
          WHERE
            q.question_id = ?
    SQL

    results.map { |result| User.new(result) }
  end
  
  def self.num_likes_for_question_id(question_id)
    result = QuestionsDatabase.instance.get_first_row(<<-SQL, question_id)
          SELECT
            COUNT(user_id)
          FROM
            question_likes
          WHERE
            question_id = ?
    SQL
    result.values.first
  end
  
  def self.liked_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
          SELECT
          q.question_id, q.title, q.body, q.user_id
          FROM
            questions q
          JOIN
            question_likes ql ON (q.question_id = ql.question_id)
          WHERE
            ql.user_id = ?
    SQL

    results.map { |result| Question.new(result) }
  end
  
  def self.most_liked_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        ql.question_id, q.title, q.body, q.user_id
      FROM
        question_likes ql
      JOIN
        questions q
      ON
        (ql.question_id = q.question_id)
      GROUP BY
        ql.question_id
      ORDER BY
        COUNT(ql.question_id) DESC
    SQL

    results.map { |result| Question.new(result) }.take(n)
  end
  
  def initialize(options = {})
    @id = options['questionlike_id']
    @question_id = options['question_id']
    @user_id = options['user_id']
    @body = options['body']
  end
end

# p Reply.all
# p Question.find_by_id(1)
# user = User.find_by_name("CJ", "Burt-Zorko")
# #p user.authored_questions
# #p user.authored_replies
#
# q = Question.find_by_author_id(user.id)

#p q.first.author

# p Question.find_by_id(1).replies
#
# p user.authored_replies
#
# p Reply.find_by_id(2).author
#
# p Reply.find_by_id(1).question
#
# p Reply.find_by_id(2).parent_reply

# p Reply.find_by_id(1).child_replies
#
# p QuestionFollower.followers_for_question_id(1)
#
# p QuestionFollower.followed_questions_for_user_id(3)
#
# p user.followed_questions

# p QuestionFollower.most_followed_questions(2)
#
# p QuestionLike.likers_for_question_id(2)
#
# p QuestionLike.num_likes_for_question_id(1)
#
# p QuestionLike.liked_questions_for_user_id(1)
#
# p QuestionLike.most_liked_questions(1)

# p User.find_by_id(2).average_karma

user = User.new({'fname' => "Jeff", 'lname' => "Burt-Zorko"})
user.save

p User.all





