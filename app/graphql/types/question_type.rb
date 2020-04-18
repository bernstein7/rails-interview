module Types
  class QuestionType < Types::BaseObject
    field :id, Integer, null: false
    field :title, String, null: false
    field :private, GraphQL::Types::Boolean, null: false
    field :created_at, Types::DateTimeType, null: false
    field :updated_at, Types::DateTimeType, null: false

    field :answers, AnswerType.connection_type, null: false
    field :user, UserType, null: false

    def answers
      Loaders::AssociationLoader.for(Question, :answers).load(object)
    end

    def user
      Loaders::AssociationLoader.for(Question, :user).load(object)
    end
  end
end
