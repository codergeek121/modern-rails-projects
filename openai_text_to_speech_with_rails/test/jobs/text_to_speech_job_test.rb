require "test_helper"

class TextToSpeechJobTest < ActiveJob::TestCase
  setup do
    @article = articles(:one)
  end

  test "send's the article's content to the speech API" do
    tts_request = stub_tts_request.with(
        headers: {
          'Authorization'=>'Bearer test',
        },
        body: {
          model: "tts-1-hd",
          input: @article.content,
          voice: "echo",
          speed: 0.95
        }.to_json
      )

    TextToSpeechJob.perform_now(@article)

    assert_requested tts_request
  end

  test "attaches the response as audiofile with an unique filename" do
    stub_tts_request.to_return(body: "mp3blobcontent")
    
    TextToSpeechJob.perform_now(@article)

    assert @article.audio.attached?
    assert_equal "article--#{@article.id}.mp3", @article.audio_blob.filename.to_s
  end

  test "retries multiple times for exceptions" do
    stub_tts_request.to_timeout

    TextToSpeechJob.perform_later(@article)

    9.times do
      assert_enqueued_jobs 1, only: TextToSpeechJob
      perform_enqueued_jobs
    end
  end

  private

  def stub_tts_request
    stub_request(:post, "https://api.openai.com/v1/audio/speech")
  end
end
