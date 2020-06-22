require 'rails_helper'

RSpec.describe "Customer API", type: :request do
  describe 'GET /customers' do
    describe '一般ユーザー' do
      context '自社テナント顧客の場合' do
        it '顧客の一覧を取得することができる' do
          user = create :user
          customer = create :customer, tenant: user.tenant
          login user

          get '/customers'

          expect(response.status).to eq 200
          customer_json = JSON.parse(response.body).first
          expect(customer_json.keys.all?{|key| customer.attributes.keys.include?(key)}).to eq true
        end
      end
      context '自社テナント顧客以外の場合' do
        it '顧客の一覧を取得することができない' do
          user = create :user
          customer = create :customer
          login user

          get '/customers'

          expect(response.status).to eq 200
          expect(JSON.parse(response.body).size).to eq 0
        end
      end
    end
    describe '管理者' do
      context '自社テナント顧客の場合' do
        it '顧客の一覧を取得することができる' do
          user = create :user, administrator: true
          customer = create :customer, tenant: user.tenant
          login user

          get '/customers'

          expect(response.status).to eq 200
          customer_json = JSON.parse(response.body).first
          expect(customer_json.keys.all?{|key| customer.attributes.keys.include?(key)}).to eq true
        end
      end
      context '自社テナント顧客以外の場合' do
        it '顧客の一覧を取得することができない' do
          user = create :user, administrator: true
          customer = create :customer
          login user

          get '/customers'

          expect(response.status).to eq 200
          expect(JSON.parse(response.body).size).to eq 0
        end
      end
    end
    describe '未ログイン' do
      it '顧客の一覧を取得することができない' do
        user = create :user, administrator: true
        customer = create :customer, tenant: user.tenant

        get '/customers'

        expect(response.status).to eq 401
      end
    end
  end

  describe "GET /customer/:id" do
    describe '一般ユーザー' do
      context '自社テナント顧客の場合' do
        it '顧客の詳細を取得することができる' do
          user = create :user
          customer = create :customer, tenant: user.tenant
          login user

          get "/customers/#{customer.id}"

          expect(response.status).to eq 200
          json = JSON.parse(response.body)
          expect(json.keys.all?{|key| customer.attributes.keys.include?(key)}).to eq true
        end
      end
      context '自社テナント顧客以外の場合' do
        it '顧客の詳細を取得することができない' do
          user = create :user
          customer = create :customer
          login user

          get "/customers/#{customer.id}"

          expect(response.status).to eq 404
        end
      end
    end
    describe '管理者' do
      context '自社テナント顧客の場合' do
        it '顧客の詳細を取得することができる' do
          user = create :user, administrator: true
          customer = create :customer, tenant: user.tenant
          login user

          get "/customers/#{customer.id}"

          expect(response.status).to eq 200
          json = JSON.parse(response.body)
          expect(json.keys.all?{|key| customer.attributes.keys.include?(key)}).to eq true
        end
      end
      context '自社テナント顧客以外の場合' do
        it '顧客の詳細を取得することができない' do
          user = create :user, administrator: true
          customer = create :customer
          login user

          get "/customers/#{customer.id}"

          expect(response.status).to eq 404
        end
      end
    end
    describe '未ログイン' do
      it '顧客の詳細を取得することができない' do
        user = create :user, administrator: true
        customer = create :customer, tenant: user.tenant

        get "/customers/#{customer.id}"

        expect(response.status).to eq 401
      end
    end
  end

  describe "POST /customers" do
    describe '一般ユーザー' do
      context '全てのパラメータが正しい場合' do
        it '顧客の作成をすることができる' do
          user = create :user
          customer = create :customer, tenant: user.tenant
          login user
          params = attributes_for :customer

          post '/customers', params: params

          expect(response.status).to eq 201
          json = JSON.parse(response.body)
          expect(json.keys.all?{|key| customer.attributes.keys.include?(key)}).to eq true
        end
      end
      context 'パラメータが不正な場合' do
        it '顧客の作成をすることができない' do
          user = create :user
          customer = create :customer
          login user
          params = attributes_for :customer
          params[:postal_code] = '1234567'

          post '/customers', params: params

          expect(response.status).to eq 400
          json = JSON.parse(response.body)
          expect(json['errors'].present?).to eq true
        end
      end
    end
    describe '管理者' do
      context '全てのパラメータが正しい場合' do
        it '顧客の作成をすることができる' do
          user = create :user
          customer = create :customer, tenant: user.tenant
          login user
          params = attributes_for :customer

          post '/customers', params: params

          expect(response.status).to eq 201
          json = JSON.parse(response.body)
          expect(json.keys.all?{|key| customer.attributes.keys.include?(key)}).to eq true
        end
      end
      context 'パラメータが不正な場合' do
        it '顧客の作成をすることができない' do
          user = create :user
          customer = create :customer
          login user
          params = attributes_for :customer
          params[:postal_code] = '1234567'

          post '/customers', params: params

          expect(response.status).to eq 400
          json = JSON.parse(response.body)
          expect(json['errors'].present?).to eq true
        end
      end
    end
    describe '未ログイン' do
      it '顧客の作成をすることができない' do
        user = create :user, administrator: true
        customer = create :customer, tenant: user.tenant
        params = attributes_for :customer

        post '/customers', params: params

        expect(response.status).to eq 401
      end
    end
  end

  describe "PATCH /customers/:id" do
    describe '一般ユーザー' do
      context '全てのパラメータが正しい場合' do
        it '顧客の更新をすることができる' do
          user = create :user
          customer = create :customer, tenant: user.tenant
          login user
          params = attributes_for :customer

          patch "/customers/#{customer.id}", params: params

          expect(response.status).to eq 200
          json = JSON.parse(response.body)
          expect(json.keys.all?{|key| customer.attributes.keys.include?(key)}).to eq true
        end
      end
      context 'パラメータが不正な場合' do
        it '顧客の更新をすることができない' do
          user = create :user
          customer = create :customer, tenant: user.tenant
          login user
          params = attributes_for :customer
          params[:postal_code] = '1234567'

          patch "/customers/#{customer.id}", params: params

          expect(response.status).to eq 400
        end
      end
    end
    describe '管理者' do
      context '全てのパラメータが正しい場合' do
        it '顧客の更新をすることができる' do
          user = create :user
          customer = create :customer, tenant: user.tenant
          login user
          params = attributes_for :customer

          patch "/customers/#{customer.id}", params: params

          expect(response.status).to eq 200
          json = JSON.parse(response.body)
          expect(json.keys.all?{|key| customer.attributes.keys.include?(key)}).to eq true
        end
      end
      context 'パラメータが不正な場合' do
        it '顧客の更新をすることができない' do
          user = create :user
          customer = create :customer, tenant: user.tenant
          login user
          params = attributes_for :customer
          params[:postal_code] = '1234567'

          patch "/customers/#{customer.id}", params: params

          expect(response.status).to eq 400
        end
      end
    end
    describe '未ログイン' do
      it '顧客の更新をすることができない' do
        user = create :user, administrator: true
        customer = create :customer, tenant: user.tenant
        params = attributes_for :customer

        patch "/customers/#{customer.id}", params: params

        expect(response.status).to eq 401
      end
    end
  end

  describe "DELETE /customers/:id" do
    describe '一般ユーザー' do
      context '自社テナント顧客の場合' do
        it '顧客を削除することができる' do
          user = create :user
          customer = create :customer, tenant: user.tenant
          login user

          delete "/customers/#{customer.id}"

          expect(response.status).to eq 204
        end
      end
      context '自社テナント顧客以外の場合' do
        it '顧客を削除することができない' do
          user = create :user
          customer = create :customer
          login user

          delete "/customers/#{customer.id}"

          expect(response.status).to eq 404
        end
      end
    end
    describe '管理者' do
      context '自社テナント顧客の場合' do
        it '顧客を削除することができる' do
          user = create :user, administrator: true
          customer = create :customer, tenant: user.tenant
          login user

          delete "/customers/#{customer.id}"

          expect(response.status).to eq 204
        end
      end
      context '自社テナント顧客以外の場合' do
        it '顧客を削除することができない' do
          user = create :user, administrator: true
          customer = create :customer
          login user

          delete "/customers/#{customer.id}"

          expect(response.status).to eq 404
        end
      end
    end
    describe '未ログイン' do
      it '顧客の削除をすることができない' do
        user = create :user, administrator: true
        customer = create :customer, tenant: user.tenant

        delete "/customers/#{customer.id}"

        expect(response.status).to eq 401
      end
    end
  end
end
