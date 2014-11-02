20.times do
  user = User.new
  user.username = Faker::Internet.user_name
  user.password = "password"
  user.save
end

10.times do
  sub = Sub.new
  sub.title = Faker::App.name
  sub.moderator_id = User.all.sample.id
  sub.description = Faker::Company.bs
  sub.save
end

30.times do
  post = Post.new
  post.title = Faker::Company.catch_phrase
  post.content = Faker::Hacker.say_something_smart
  post.sub_id = Sub.all.sample.id
  post.author_id = User.all.sample.id
  post.save
end

30.times do
  comment = Comment.new
  comment.content = Faker::Lorem.sentence
  comment.author_id = User.all.sample.id
  comment.post_id = Post.all.sample.id
  comment.parent_comment_id = [nil, Comment.all.sample.id].sample
  comment.save
end
