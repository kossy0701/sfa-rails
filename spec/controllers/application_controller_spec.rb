require 'rails_helper'

RSpec.describe "ApplicationController", type: :controller do
  describe 'method #ip_restriction!' do
    context '未ログインの場合' do
      it '401エラーが返り値となる' do
      end
    end
    context 'リクエスト元のIPアドレスが登録されたものでない場合' do
      it '403エラーが返り値となる' do
      end
    end
  end

  describe 'method #current_user_tenant' do
    context '未ログインの場合' do
      it '401エラーが返り値となる' do
      end
    end
    context 'ログイン済みの場合' do
      it 'ログインユーザーが所属するテナントオブジェクトが返り値となる' do
      end
    end
  end
end
