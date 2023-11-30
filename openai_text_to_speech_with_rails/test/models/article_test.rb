require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  test "creating an article will enqueue a TTS job" do
    article = Article.create(content: 'some content')

    assert_enqueued_jobs(1, only: TextToSpeechJob)
  end

  test "updating an article's content will enqueue a TTS job" do
    articles(:one).update!(content: "Programming is fun!")

    assert_enqueued_jobs(1, only: TextToSpeechJob)
  end

  test "touching an article will not enqueue a TTS job" do
    articles(:one).touch

    assert_enqueued_jobs(0, only: TextToSpeechJob)
  end
end
