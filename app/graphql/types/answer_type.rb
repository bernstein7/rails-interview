module Types
  class AnswerType < Types::BaseObject
    field :id, Integer, null: true
    field :body, String, null: true
    field :created_at, Types::DateTimeType, null: true
    field :updated_at, Types::DateTimeType, null: true
    field :user, UserType, null: :false
    field :question, QuestionType, null: :false

    def user
      Loaders::AssociationLoader.for(Answer, :user).load(object)
    end

    def question
      Loaders::AssociationLoader.for(Answer, :question).load(object)
    end
  end
end
