class User < ApplicationRecord
  has_many :questions
  has_many :answers

  scope :with_answers, -> { distinct.joins(:answers) }
  scope :without_answers, lambda {
    left_joins(:answers)
      .group('users.id')
      .having('count(answers) = 0')
  }
end
