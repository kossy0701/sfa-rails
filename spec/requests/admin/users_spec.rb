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
          expect(user_json.keys.all?{|key| user.attributes.keys.include?(key)}).to eq true
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
          expect(json.keys.all?{|key| user.attributes.keys.include?(key)}).to eq true
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
