# OpenAI TTS with Rails

Read more about the project in the actual blogpost: https://www.modern-rails.com/posts/using-the-openai-text-to-speech-api-with-rails/

## Setup

1. Run `bin/setup`.
2. Run `rails credentials:edit --environment development` and provide your own OpenAI API token `open_ai_access_token: <yourtokengoeshere>`
3. Run `rails server`
4. Visit [/articles](localhost:3000/articles)

Have fun!

## Tests

1. Run `bin/setup`.
2. Run `rails credentials:edit --environment test` and add `open_ai_access_token: test`
3. Run `rails test`
