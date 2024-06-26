LetterOpener.configure do |config|
  config.location = Rails.root.join('tmp', 'letter_opener')
  config.message_template = :light
end
