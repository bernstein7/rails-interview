module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :questions, QuestionType.connection_type, null: false

    def questions
      Question.all
    end
  end
end
