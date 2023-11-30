class Article < ApplicationRecord
  broadcasts

  has_one_attached :audio

  after_commit :generate_audio_content_mp3, if: :content_previously_changed?

  private

  def generate_audio_content_mp3
    TextToSpeechJob.perform_later(self)
  end
end
