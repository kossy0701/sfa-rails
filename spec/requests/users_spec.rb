require 'rails_helper'

RSpec.describe 'User API', type: :request do
  let(:user) { create :user, administrator: false }

  describe 'GET /users/:id' do
    context '一般ユーザーの場合' do
      it 'ログインユーザーの詳細を取得することができる' do
        login user

        get "/users/#{user.id}"

        expect(response.status).to eq 200
        json = JSON.parse(response.body)
        expect(json['id']).to eq user.id
        expect(json['last_name']).to eq user.last_name
        expect(json['first_name']).to eq user.first_name
        expect(json['last_name_kana']).to eq user.last_name_kana
        expect(json['first_name_kana']).to eq user.first_name_kana
        expect(json['email']).to eq user.email
        expect(json['birthday']).to eq user.birthday.to_s
        expect(json['sex']).to eq user.sex
        expect(json['administrator']).to eq user.administrator
        expect(json['disable']).to eq user.disable
        expect(json['prefecture_id']).to eq user.prefecture_id
        expect(json['tenant_id']).to eq user.tenant_id
        expect(json['manager_id']).to eq user.manager_id
        expect(json['image']).to eq user.encoded_image
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
          expect(json['id']).to eq user_2.id
          expect(json['last_name']).to eq user_2.last_name
          expect(json['first_name']).to eq user_2.first_name
          expect(json['last_name_kana']).to eq user_2.last_name_kana
          expect(json['first_name_kana']).to eq user_2.first_name_kana
          expect(json['email']).to eq user_2.email
          expect(json['birthday']).to eq user_2.birthday.to_s
          expect(json['sex']).to eq user_2.sex
          expect(json['administrator']).to eq user_2.administrator
          expect(json['disable']).to eq user_2.disable
          expect(json['prefecture_id']).to eq user_2.prefecture_id
          expect(json['tenant_id']).to eq user_2.tenant_id
          expect(json['manager_id']).to eq user_2.manager_id
          expect(json['image']).to eq user_2.encoded_image
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
