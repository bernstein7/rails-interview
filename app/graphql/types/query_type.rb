module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :answers, AnswerType.connection_type, null: false
    field :users, UserType.connection_type, null: false do
      argument :has_answers, GraphQL::Types::Boolean, required: false
    end
    field :questions, QuestionType.connection_type, null: false

    def answers
      Answer.all
    end

    def users(has_answers: nil)
      User.merge(Filters::User::HasAnswers.new(has_answers).relation)
    end

    def questions
      Question.all
    end
  end
end
