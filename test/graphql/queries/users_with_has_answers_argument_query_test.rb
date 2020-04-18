require 'test_helper'

class UsersWithHasAnswersArgumentQueryTest < ActiveSupport::TestCase
  def build_query(has_answers:)
    <<-GRAPHQL
    {
      users(
        hasAnswers: #{has_answers}
      ) {
        edges {
          node {
            id
            name
            answers {
              edges {
                node {
                  id
                  body
                }
              }
            }
          }
        }
      }
    }
    GRAPHQL
  end

  class WithHasAnswersSetToTrueTest < UsersWithHasAnswersArgumentQueryTest
    test 'loads only users with answers' do
      result = RailsInterviewSchema.execute(build_query(has_answers: true))
      nodes = result['data']['users']['edges']

      assert_equal nodes.size, User.with_answers.count
    end
  end

  class WithHasAnswersSetToFalseTest < UsersWithHasAnswersArgumentQueryTest
    test 'loads only users without answers' do
      result = RailsInterviewSchema.execute(build_query(has_answers: false))
      nodes = result['data']['users']['edges']

      assert_equal nodes.size, User.without_answers.count.values.sum
    end
  end
end
