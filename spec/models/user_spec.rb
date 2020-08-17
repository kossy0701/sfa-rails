require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  describe 'method #full_name' do
    it 'フルネームが返り値となる' do
      full_name = "#{user.last_name} #{user.first_name}"

      expect(user.full_name).to eq full_name
    end
  end

  describe 'method #encoded_image' do
    context 'imageがattachされている場合' do
      it 'Base64でエンコードされた文字列が返り値となる' do
        encoded_str = "data:image/png;base64,#{Base64.encode64(user.image.download)}"

        expect(user.encoded_image).to eq encoded_str
      end
    end
    context 'imageがattachされていない場合' do
      it 'nilが返り値となる' do
        user.image.purge

        expect(user.encoded_image).to eq nil
      end
    end
  end
end
