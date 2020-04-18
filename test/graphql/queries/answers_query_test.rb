require 'test_helper'

class AnswersQueryTest < ActiveSupport::TestCase
  def build_query(count: nil)
    items_limit_part = count ? "(first: #{count})" : ''

    <<-GRAPHQL
      {
        answers(first: 1) {
          edges {
            node {
              id
              body
              user {
                id
                name
              }
              question {
                id
                title
                private
              }
            }
          }
        }
      }
    GRAPHQL
  end

  class QuestionsWithLimitArgQueryTest < AnswersQueryTest
    test 'loads collection of single answer' do
      result = RailsInterviewSchema.execute(build_query(count: 1))
      nodes = result['data']['answers']['edges']

      assert_equal nodes.size, 1
    end

    test 'all answers have correct set of properties' do
      result = RailsInterviewSchema.execute(build_query)
      nodes = result['data']['answers']['edges']

      assert nodes.all? { |node| node['node'].keys == %w(id body user question)}
    end

    test 'has user as an object' do
      result = RailsInterviewSchema.execute(build_query)
      nodes = result['data']['answers']['edges']

      assert_equal nodes.first['node']['user'].keys, %w(id name)
    end

    test 'has question as an object' do
      result = RailsInterviewSchema.execute(build_query)
      nodes = result['data']['answers']['edges']

      assert_equal nodes.first['node']['question'].keys, %w(id title private)
    end
  end
end
