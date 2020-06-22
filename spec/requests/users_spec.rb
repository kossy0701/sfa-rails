require 'rails_helper'

RSpec.describe 'User API', type: :request do
  describe 'GET /users/:id' do
    describe '一般ユーザー' do
      it 'ログインユーザーの詳細を取得することができる' do
        user = create :user, administrator: false
        login user

        get "/users/#{user.id}"

        expect(response.status).to eq 200
        json = JSON.parse(response.body)
        expect(json.keys.all?{|key| user.attributes.keys.include?(key)}).to eq true
      end
    end
    describe '管理者' do
      context '自社テナントのユーザーの場合' do
        it 'ユーザーの詳細を取得することができる' do
          user_1 = create :user, administrator: true
          user_2 = create :user, tenant: user_1.tenant, administrator: true
          login user_1

          get "/users/#{user_2.id}"

          expect(response.status).to eq 200
          json = JSON.parse(response.body)
          expect(json.keys.all?{|key| user_2.attributes.keys.include?(key)}).to eq true
        end
      end
      context '自社テナントのユーザーではない場合' do
        it 'ユーザーの詳細を取得することができない' do
          user_1 = create :user, administrator: true
          user_2 = create :user, administrator: true
          login user_1

          get "/users/#{user_2.id}"

          expect(response.status).to eq 404
        end
      end
    end
  end
end
