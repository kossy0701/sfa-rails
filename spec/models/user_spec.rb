require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'method #full_name' do
    it 'フルネームが返り値となる' do
      user = create :user
      full_name = "#{user.last_name} #{user.first_name}"

      expect(user.full_name).to eq full_name
    end
  end
end
