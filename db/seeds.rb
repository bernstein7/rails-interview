# Users
users = []

20.times do
  users << User.create(name: FFaker::Name.name)
end

# Questions and Answers
20.times do
  question = Question.create(
    title: FFaker::HipsterIpsum.sentence.gsub(/\.$/, "?"),
    private: FFaker::Boolean.random,
    user: users.sample
  )

  rand(1..3).times do
    Answer.create(
      question: question,
      body: FFaker::HipsterIpsum.sentence,
      user: users.sample
    )
  end
end
