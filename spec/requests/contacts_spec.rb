require 'rails_helper'

RSpec.describe 'Contact API', type: :request do
  describe '/customers/:id/contacts' do
    describe '一般ユーザー' do
      context '自社テナント顧客の場合' do
        it '顧客に紐づいたコンタクト履歴の一覧を取得できる' do
          user = create :user, administrator: false
          customer = create :customer, tenant: user.tenant
          contact = create :contact, user: user, customer: customer
          login user

          get "/customers/#{customer.id}/contacts"

          expect(response.status).to eq 200
          contact_json = JSON.parse(response.body).first
          expect(contact_json.keys.all?{|key| contact.attributes.keys.include?(key)}).to eq true
        end
      end
      context '自社テナント顧客ではない場合' do
        it '顧客に紐づいたコンタクト履歴の一覧を取得できない' do
          user = create :user, administrator: false
          customer = create :customer
          contact = create :contact, user: user, customer: customer
          login user

          get "/customers/#{customer.id}/contacts"

          expect(response.status).to eq 404
        end
      end
    end
    describe '管理者' do
      context '自社テナント顧客の場合' do
        it '顧客に紐づいたコンタクト履歴の一覧を取得できる' do
          user = create :user, administrator: true
          customer = create :customer, tenant: user.tenant
          contact = create :contact, user: user, customer: customer
          login user

          get "/customers/#{customer.id}/contacts"

          expect(response.status).to eq 200
          contact_json = JSON.parse(response.body).first
          expect(contact_json.keys.all?{|key| contact.attributes.keys.include?(key)}).to eq true
        end
      end
      context '自社テナント顧客ではない場合' do
        it '顧客に紐づいたコンタクト履歴の一覧を取得できない' do
          user = create :user, administrator: true
          customer = create :customer
          contact = create :contact, user: user, customer: customer
          login user

          get "/customers/#{customer.id}/contacts"

          expect(response.status).to eq 404
        end
      end
    end
  end

  describe '/customers/:id/contacts/:id' do
    describe '一般ユーザー' do
      context '自社テナント顧客の場合' do
        it '顧客に紐づいたコンタクト履歴の一覧を取得できる' do
          user = create :user, administrator: false
          customer = create :customer, tenant: user.tenant
          contact = create :contact, user: user, customer: customer
          login user

          get "/customers/#{customer.id}/contacts/#{contact.id}"

          expect(response.status).to eq 200
          json = JSON.parse(response.body)
          expect(json.keys.all?{|key| contact.attributes.keys.include?(key)}).to eq true
        end
      end
      context '自社テナント顧客ではない場合' do
        it '顧客に紐づいたコンタクト履歴の一覧を取得できない' do
          user = create :user, administrator: false
          customer = create :customer
          contact = create :contact, user: user, customer: customer
          login user

          get "/customers/#{customer.id}/contacts/#{contact.id}"

          expect(response.status).to eq 404
        end
      end
    end
    describe '管理者' do
      context '自社テナント顧客の場合' do
        it '顧客に紐づいたコンタクト履歴の一覧を取得できる' do
          user = create :user, administrator: true
          customer = create :customer, tenant: user.tenant
          contact = create :contact, user: user, customer: customer
          login user

          get "/customers/#{customer.id}/contacts/#{contact.id}"

          expect(response.status).to eq 200
          json = JSON.parse(response.body)
          expect(json.keys.all?{|key| contact.attributes.keys.include?(key)}).to eq true
        end
      end
      context '自社テナント顧客ではない場合' do
        it '顧客に紐づいたコンタクト履歴の一覧を取得できない' do
          user = create :user, administrator: true
          customer = create :customer
          contact = create :contact, user: user, customer: customer
          login user

          get "/customers/#{customer.id}/contacts/#{contact.id}"

          expect(response.status).to eq 404
        end
      end
    end
  end

  describe '/customers/:id/contacts' do
    describe '一般ユーザー' do
      context '自社テナント顧客の場合' do
        it '顧客に紐づいたコンタクト履歴を作成できる' do
          user = create :user, administrator: false
          customer = create :customer, tenant: user.tenant
          contact = create :contact, user: user, customer: customer
          login user
          params = attributes_for :contact

          post "/customers/#{customer.id}/contacts", params: params

          expect(response.status).to eq 201
          json = JSON.parse(response.body)
          expect(json.keys.all?{|key| contact.attributes.keys.include?(key)}).to eq true
        end
      end
      context '自社テナント顧客ではない場合' do
        it '顧客に紐づいたコンタクト履歴を作成できない' do
          user = create :user, administrator: false
          customer = create :customer
          contact = create :contact, user: user, customer: customer
          login user
          params = attributes_for :contact

          post "/customers/#{customer.id}/contacts", params: params

          expect(response.status).to eq 404
        end
      end
    end
    describe '管理者' do
      context '自社テナント顧客の場合' do
        it '顧客に紐づいたコンタクト履歴を作成できる' do
          user = create :user, administrator: true
          customer = create :customer, tenant: user.tenant
          contact = create :contact, user: user, customer: customer
          login user
          params = attributes_for :contact

          post "/customers/#{customer.id}/contacts", params: params

          expect(response.status).to eq 201
          json = JSON.parse(response.body)
          expect(json.keys.all?{|key| contact.attributes.keys.include?(key)}).to eq true
        end
      end
      context '自社テナント顧客ではない場合' do
        it '顧客に紐づいたコンタクト履歴の一覧を取得できない' do
          user = create :user, administrator: true
          customer = create :customer
          contact = create :contact, user: user, customer: customer
          login user
          params = attributes_for :contact

          post "/customers/#{customer.id}/contacts", params: params

          expect(response.status).to eq 404
        end
      end
    end
  end
end

