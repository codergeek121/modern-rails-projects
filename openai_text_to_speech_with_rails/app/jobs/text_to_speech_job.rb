class TextToSpeechJob < ApplicationJob
  queue_as :default
  retry_on Faraday::Error, wait: :polynomially_longer, attempts: 10

  def perform(article)
    response = TextToSpeech.new.speech(article.content)
    article.audio.attach(
      io: StringIO.new(response, 'rb'),
      filename: "article--#{article.id}.mp3"
    )
  end
end
