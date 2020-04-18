require 'test_helper'

class UsersWithoutArgumentsQueryTest < ActiveSupport::TestCase
  query_string = <<-GRAPHQL
    {
      users {
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
            questions {
              edges {
                node {
                  id
                  title
                  private
                }
              }
            }
          }
        }
      }
    }
  GRAPHQL

  test 'loads all the questions' do
    result = RailsInterviewSchema.execute(query_string)
    nodes = result['data']['users']['edges']

    assert_equal nodes.size, User.count
  end

  test 'all users have correct set of properties' do
    result = RailsInterviewSchema.execute(query_string)
    nodes = result['data']['users']['edges']

    assert nodes.all? { |node| node['node'].keys == %w(id name answers questions)}
  end

  test 'has answers as a connection' do
    result = RailsInterviewSchema.execute(query_string)
    nodes = result['data']['users']['edges']

    assert nodes.first['node']['answers']['edges'].is_a? Array
  end

  test 'has questions as a connection' do
    result = RailsInterviewSchema.execute(query_string)
    nodes = result['data']['users']['edges']

    assert nodes.first['node']['questions']['edges'].is_a? Array
  end
end
