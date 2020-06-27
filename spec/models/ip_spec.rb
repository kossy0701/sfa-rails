require 'rails_helper'

RSpec.describe Ip, type: :model do
  describe 'method #content' do
    it 'IPAddress::IPv4インスタンスが返り値となる' do
      ip = create :ip

      expect(ip.content.is_a?(IPAddress::IPv4)).to eq true
    end
  end

describe 'method #content=(value)' do
    describe '引数がIPAddress::IPv4クラスのオブジェクトの場合' do
      it 'IPAddress::IPv4クラスのオブジェクトが返り値となる' do
        ip = create :ip, content: '10.0.1.2'
        ipv4 = IPAddress::IPv4.new('127.0.0.1')
        expect(ip.content = ipv4).to eq ipv4
      end
    end
    describe '引数がIPAddress::IPv4クラスのオブジェクトでない場合' do
      it '引数が返り値となる' do
        ip = create :ip, content: '10.0.1.2'
        address = '127.0.0.1'
        expect(ip.content = address).to eq address
      end
    end
  end

  describe 'method #setted_at' do
    it 'created_atを%y/%m/%dでフォーマットした文字列が返り値となる' do
      ip = create :ip
      setted_at = ip.created_at.localtime.to_date.strftime('%Y/%m/%d')

      expect(ip.setted_at).to eq setted_at
    end
  end
end
