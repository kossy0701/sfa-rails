require 'rails_helper'

RSpec.describe "Ip API", type: :request do
  describe 'GET /ips' do
    describe '一般ユーザー' do
      context '自社テナントIPアドレスの場合' do
        it 'IPアドレスの一覧を取得することができない' do
          user = create :user, administrator: false
          create :ip, tenant: user.tenant, content: '127.0.0.1'
          login user

          get '/ips'

          expect(response.status).to eq 403
        end
      end
      context '自社テナントIPアドレスでない場合' do
        it 'IPアドレスの一覧を取得することができない' do
          user = create :user, administrator: false
          create :ip, content: '127.0.0.1'
          login user

          get '/ips'

          expect(response.status).to eq 403
        end
      end
    end
    describe '管理者' do
      context '自社テナントIPアドレスの場合' do
        it 'IPアドレスの一覧を取得することができる' do
          user = create :user, administrator: true
          ip = create :ip, tenant: user.tenant, content: '127.0.0.1'
          login user

          get '/ips'

          expect(response.status).to eq 200
          ip_json = JSON.parse(response.body).first
          expect(ip_json.keys.all?{|key| ip.attributes.keys.include?(key)}).to eq true
        end
      end
      context '自社テナントIPアドレスでない場合' do
        it '他テナントのIPアドレスの一覧を取得することができない' do
          user = create :user, administrator: true
          create :ip
          login user

          get '/ips'

          expect(response.status).to eq 200
          expect(JSON.parse(response.body).size).to eq 0
        end
      end
    end
  end

  describe 'GET /ips/:id' do
    describe '一般ユーザー' do
      context '自社テナントIPアドレスの場合' do
        it 'IPアドレスの詳細を取得することができない' do
          user = create :user, administrator: false
          ip = create :ip, tenant: user.tenant, content: '127.0.0.1'
          login user

          get "/ips/#{ip.id}"

          expect(response.status).to eq 403
        end
      end
      context '自社テナントIPアドレスでない場合' do
        it 'IPアドレスの詳細を取得することができない' do
          user = create :user, administrator: false
          ip = create :ip, content: '127.0.0.1'
          login user

          get "/ips/#{ip.id}"

          expect(response.status).to eq 403
        end
      end
    end
    describe '管理者' do
      context '自社テナントIPアドレスの場合' do
        it 'IPアドレスの詳細を取得することができる' do
          user = create :user, administrator: true
          ip = create :ip, tenant: user.tenant, content: '127.0.0.1'
          login user

          get "/ips/#{ip.id}"

          expect(response.status).to eq 200
          json = JSON.parse(response.body)
          expect(json.keys.all?{|key| ip.attributes.keys.include?(key)}).to eq true
        end
      end
      context '自社テナントIPアドレスでない場合' do
        it '他テナントのIPアドレスの詳細を取得することができない' do
          user = create :user, administrator: true
          ip = create :ip
          login user

          get "/ips/#{ip.id}"

          expect(response.status).to eq 404
        end
      end
    end
  end

  describe 'POST /ips' do
    describe '一般ユーザー' do
      it 'IPアドレス制限を設定することができない' do
        user = create :user, administrator: false
        login user
        params = attributes_for :ip

        post "/ips", params: params

        expect(response.status).to eq 403
      end
    end
    describe '管理者' do
      it 'IPアドレス制限を設定することができる' do
        user = create :user, administrator: true
        login user
        params = attributes_for :ip

        post "/ips", params: params

        expect(response.status).to eq 201
        json = JSON.parse(response.body)
        ip = Ip.last
        expect(json['id']).to eq ip.id
        expect(json['tenant_id']).to eq ip.tenant_id
        expect(json['content']).to eq ip.content.address
        expect(json['created_at']).to eq ip.created_at.iso8601(3)
        expect(json['updated_at']).to eq ip.updated_at.iso8601(3)
      end
    end
  end
end
