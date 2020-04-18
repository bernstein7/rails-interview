module Types
  class AnswerType < Types::BaseObject
    field :id, Integer, null: true
    field :body, String, null: true
    field :created_at, Types::DateTimeType, null: true
    field :updated_at, Types::DateTimeType, null: true
  end
end
