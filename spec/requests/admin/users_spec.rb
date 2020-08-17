require 'rails_helper'

RSpec.describe "Admin::User API", type: :request do
  describe "GET /admin/users" do
    describe '一般ユーザー' do
      it '自社テナントのユーザー一覧を取得することができない' do
        user = create :user, administrator: false
        login user

        get '/admin/users'

        expect(response.status).to eq 403
      end
    end
    describe '管理者' do
      context '自社テナントのユーザーの場合' do
        it '自社テナントのユーザー一覧を取得することができる' do
          user = create :user, administrator: true
          login user

          get '/admin/users'

          expect(response.status).to eq 200
          user_json = JSON.parse(response.body).first
          expect(user_json['id']).to eq user.id
          expect(user_json['last_name']).to eq user.last_name
          expect(user_json['first_name']).to eq user.first_name
          expect(user_json['last_name_kana']).to eq user.last_name_kana
          expect(user_json['first_name_kana']).to eq user.first_name_kana
          expect(user_json['email']).to eq user.email
          expect(user_json['birthday']).to eq user.birthday.to_s
          expect(user_json['sex']).to eq user.sex
          expect(user_json['administrator']).to eq user.administrator
          expect(user_json['disable']).to eq user.disable
          expect(user_json['prefecture_id']).to eq user.prefecture_id
          expect(user_json['tenant_id']).to eq user.tenant_id
          expect(user_json['manager_id']).to eq user.manager_id
          expect(user_json['image']).to eq user.encoded_image
        end
      end
      context '自社テナントのユーザー以外の場合' do
        it 'ユーザー一覧を取得することができない' do
          user_1 = create :user, administrator: true
          user_2 = create :user, administrator: true
          login user_1

          get '/admin/users'

          expect(response.status).to eq 200
          expect(JSON.parse(response.body).size).to eq 1
        end
      end
    end
  end

  describe "GET /admin/users/:id" do
    describe '一般ユーザー' do
      it '自社テナントのユーザー詳細を取得することができない' do
        user = create :user, administrator: false
        login user

        get "/admin/users/#{user.id}"

        expect(response.status).to eq 403
      end
    end
    describe '管理者' do
      context '自社テナントのユーザーの場合' do
        it '自社テナントのユーザー一覧を取得することができる' do
          user = create :user, administrator: true
          login user

          get "/admin/users/#{user.id}"

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
      context '自社テナントのユーザー以外の場合' do
        it 'ユーザー詳細を取得することができない' do
          user_1 = create :user, administrator: true
          user_2 = create :user, administrator: true
          login user_1

          get "/admin/users/#{user_2.id}"

          expect(response.status).to eq 404
        end
      end
    end
  end
end
