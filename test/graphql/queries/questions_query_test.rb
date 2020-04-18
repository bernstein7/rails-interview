require 'test_helper'

class QuestionsQueryTest < ActiveSupport::TestCase
  def build_query(count: nil)
    items_limit_part = count ? "(first: #{count})" : ''

    <<-GRAPHQL
      {
        questions#{items_limit_part} {
          edges {
            node {
              id
              title
              private
              answers {
                edges {
                  node {
                    id
                    body
                  }
                }
              }
              user {
                id
                name
              }
            }
          }
        }
      }
    GRAPHQL
  end

  class QuestionsWithLimitArgQueryTest < QuestionsQueryTest
    test 'loads 3 questions' do
      result = RailsInterviewSchema.execute(build_query(count: 3))
      nodes = result['data']['questions']['edges']

      assert_equal nodes.size, 3
    end
  end

  class QuestionsWithoutArgsQueryTest < QuestionsQueryTest
    test 'loads all the questions' do
      result = RailsInterviewSchema.execute(build_query)
      nodes = result['data']['questions']['edges']

      assert_equal nodes.size, Question.count
    end

    test 'all questions have answers and user' do
      result = RailsInterviewSchema.execute(build_query)
      nodes = result['data']['questions']['edges']

      assert nodes.all? { |node| node['node'].keys == %w(id title private answers user)}
    end

    test 'has answers as a connection' do
      result = RailsInterviewSchema.execute(build_query)
      nodes = result['data']['questions']['edges']

      assert nodes.first['node']['answers']['edges'].is_a? Array
    end

    test 'has user as an object' do
      result = RailsInterviewSchema.execute(build_query)
      nodes = result['data']['questions']['edges']

      assert_equal nodes.first['node']['user'].keys, %w(id name)
    end
  end
end