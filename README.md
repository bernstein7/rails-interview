## Ruby on Rails Engineer Candidate Interview Project

This Rails application is a basic skeleton of an app that serves an API about questions and answers.
It already includes 3 basic models:

* question
* answer
* user

A Question can have one or more answers, and can be private.
Every Answer belongs to one question.
Each Question has an asker (User), and each Answer has a provider (User).

## You need to accomplish the following tasks:

Implement API using with [ http://graphql-ruby.org ]( http://graphql-ruby.org ) library for following models:

* question
* answer
* user

Implementation requirements:

 * query for each model (queries, answers, users) should be paginated
 * expose all field inside model
 * has_many relation inside models should be paginated
 * use graphql-batch to solve n+1 problem
 * add basic queries test for queries, answers and users
 * add hasAnswers filter argument to user connection (see queries samples)
   * if hasAnswers == true returns users with answers
   * if hasAnswers == false returns users without answers
   * if hasAnswers argument not present in query returns all users

## Project Setup
From the top-level directory run:

```bash
bundle install

rake db:setup
```

To make sure it's all working,

```bash
rails s
```

You should see this same information.

## This gems helps accomplish interview project

``` ruby
gem 'graphql'
gem 'graphiql-rails'
gem 'graphql-batch'
```

## Queries below should be supported in implemented Graphql API

```json
{
  questions {
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
```

```json
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
```

```json
{
  users(
    hasAnswers: true
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
```

```json
{
  users(
    hasAnswers: false
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
```

```json
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
```
