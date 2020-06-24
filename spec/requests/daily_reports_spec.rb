require 'rails_helper'

RSpec.describe "DailyReport API", type: :request do
  describe "GET /users/:id/daily_reports" do
    describe '一般ユーザー' do
      it '自身の業務日報の一覧を取得することができる' do
        user = create :user, administrator: false
        daily_report = create :daily_report, user: user
        login user

        get "/users/#{user.id}/daily_reports"

        expect(response.status).to eq 200
        daily_report_json = JSON.parse(response.body).first
        expect(daily_report_json.keys.all?{|key| daily_report.attributes.keys.include?(key)}).to eq true
      end
    end
    describe '管理者' do
      context '自社テナントユーザーの場合' do
        it '自社テナントユーザーが持つ業務日報の一覧を取得できる' do
          user = create :user, administrator: true
          daily_report = create :daily_report, user: user
          login user

          get "/users/#{user.id}/daily_reports"

          expect(response.status).to eq 200
          daily_report_json = JSON.parse(response.body).first
          expect(daily_report_json.keys.all?{|key| daily_report.attributes.keys.include?(key)}).to eq true
        end
      end
      context '自社テナントユーザーではない場合' do
        it '顧客に紐づいたコンタクト履歴の一覧を取得できない' do
          user_1 = create :user, administrator: true
          user_2 = create :user, administrator: false
          daily_report = create :daily_report, user: user_2
          login user_1

          get "/users/#{user_2.id}/daily_reports"

          expect(response.status).to eq 404
        end
      end
    end
  end

  describe "GET /users/:id/daily_reports/:id" do
    describe '一般ユーザー' do
      it '自身の業務日報の詳細を取得することができる' do
        user = create :user, administrator: false
        daily_report = create :daily_report, user: user
        login user

        get "/users/#{user.id}/daily_reports/#{daily_report.id}"

        expect(response.status).to eq 200
        json = JSON.parse(response.body)
        expect(json.keys.all?{|key| daily_report.attributes.keys.include?(key)}).to eq true
      end
    end
    describe '管理者' do
      context '自社テナントユーザーの場合' do
        it '自社テナントユーザーが持つ業務日報の一覧を取得できる' do
          user = create :user, administrator: true
          daily_report = create :daily_report, user: user
          login user

          get "/users/#{user.id}/daily_reports/#{daily_report.id}"

          expect(response.status).to eq 200
          json = JSON.parse(response.body)
          expect(json.keys.all?{|key| daily_report.attributes.keys.include?(key)}).to eq true
        end
      end
      context '自社テナントユーザーではない場合' do
        it '顧客に紐づいたコンタクト履歴の一覧を取得できない' do
          user_1 = create :user, administrator: true
          user_2 = create :user, administrator: false
          daily_report = create :daily_report, user: user_2
          login user_1

          get "/users/#{user_2.id}/daily_reports/#{daily_report.id}"

          expect(response.status).to eq 404
        end
      end
    end
  end

  describe 'POST /users/:id/daily_reports' do
    describe '一般ユーザー' do
      it '自身の業務日報を作成できる' do
        user = create :user, administrator: false
        daily_report = create :daily_report, user: user
        login user
        params = attributes_for :daily_report

        post "/users/#{user.id}/daily_reports", params: params

        expect(response.status).to eq 201
        json = JSON.parse(response.body)
        expect(json.keys.all?{|key| daily_report.attributes.keys.include?(key)}).to eq true
      end
    end
    describe '管理者' do
      it '自身の業務日報を作成できる' do
        user = create :user, administrator: false
        daily_report = create :daily_report, user: user
        login user
        params = attributes_for :daily_report

        post "/users/#{user.id}/daily_reports", params: params

        expect(response.status).to eq 201
        json = JSON.parse(response.body)
        expect(json.keys.all?{|key| daily_report.attributes.keys.include?(key)}).to eq true
      end
    end
  end
end
