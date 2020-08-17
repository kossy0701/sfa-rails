require 'net/https'

class SlackClient
  DEFAULT_CHANNEL = '#general'
  DEFAULT_USERNAME = 'auto bot'
  DEFAULT_ICON = ':spiral_calendar_pad'

  def initialize(**args)
    @username = args[:username]
    @channel = args[:channel]
    @icon = args[:icon]
    @text = args[:text]
    @attachments = args[:attachments]
  end

  def notify
    uri = URI.parse(Rails.application.credentials.slack[:webhook_url])

    Net::HTTP.post_form(uri, { payload: payload })
  end

  private
   def payload
    {
      username: @username || DEFAULT_USERNAME,
      channel: @channel || DEFAULT_CHANNEL,
      icon_emoji: @icon || DEFAULT_ICON,
      text: @text,
      attachments: @attachments
    }.to_json
   end
end
