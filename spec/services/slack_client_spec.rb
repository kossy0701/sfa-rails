require 'rails_helper'

RSpec.describe SlackClient, type: :service do
  let(:params) {
    {
      username: 'test bot',
      channel: '#general',
      icon: ':spiral_calendar_pad',
      text: 'test',
      attachments: nil
    }
  }

  describe 'method #initialize(**args)' do
    it 'slack_clientインスタンスが正しく生成できる' do
      slack_client = SlackClient.new(params)

      expect(slack_client.instance_variable_get(:@username)).to eq 'test bot'
      expect(slack_client.instance_variable_get(:@channel)).to eq '#general'
      expect(slack_client.instance_variable_get(:@icon)).to eq ':spiral_calendar_pad'
      expect(slack_client.instance_variable_get(:@text)).to eq 'test'
      expect(slack_client.instance_variable_get(:@attachments)).to eq nil
    end
  end

  describe 'method #notify' do
    context 'slack通知に成功した時' do
      it 'Net::HTTPOKクラスのインスタンスが返り値となる' do
        res = SlackClient.new(params).notify

        expect(res.class).to eq Net::HTTPOK
        expect(res.message).to eq "OK"
      end
    end
    context 'slackのchannelが存在しない時' do
      it 'Net::HTTPNotFoundクラスのインスタンスが返り値となる' do
        res =
          SlackClient.new({
            username: 'test bot',
            channel: '#hogehoge',
            icon: ':spiral_calendar_pad',
            text: 'test',
            attachments: nil
          }).notify

        expect(res.class).to eq Net::HTTPNotFound
        expect(res.message).to eq "Not Found"
      end
    end
  end

  describe 'private method #payload' do
    it 'slackへのrequest用のpayloadが返り値となる' do
      json =
        {
          username: 'test bot',
          channel: '#general',
          icon_emoji: ':spiral_calendar_pad',
          text: 'test',
          attachments: nil
        }.to_json
      payload = SlackClient.new(params).send(:payload)

      expect(json).to eq payload
    end
  end
end
