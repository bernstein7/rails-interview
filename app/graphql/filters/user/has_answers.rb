module Filters
  module User
    class HasAnswers
      def initialize(has_answers)
        @has_answers = has_answers
      end

      def relation
        return ::User.all if @has_answers.nil?

        if @has_answers
          ::User.with_answers
        else
          ::User.without_answers
        end
      end
    end
  end
end
