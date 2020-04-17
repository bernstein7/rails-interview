module Types
  class QuestionType < Types::BaseObject
    field :id, Integer, null: false
    field :title, String, null: false
    field :private, GraphQL::Types::Boolean, null: false
    field :created_at, Types::DateTimeType, null: false
    field :updated_at, Types::DateTimeType, null: false
  end
end
