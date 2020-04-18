module Types
  class UserType < Types::BaseObject
    field :id, Integer, null: false
    field :name, String, null: false
    field :answers, AnswerType.connection_type, null: false
    field :questions, QuestionType.connection_type, null: false

    def answers
      Loaders::AssociationLoader.for(User, :answers).load(object)
    end

    def questions
      Loaders::AssociationLoader.for(User, :questions).load(object)
    end
  end
end
