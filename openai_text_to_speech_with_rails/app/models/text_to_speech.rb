class TextToSpeech
  def initialize
    @client = OpenAI::Client.new(access_token: Rails.application.credentials.open_ai_access_token)
  end

  def speech(text)
    @client.audio.speech(
      parameters: {
        model: "tts-1-hd",
        input: text,
        voice: "echo",
        speed: 0.95
      }
    )
  end
end
