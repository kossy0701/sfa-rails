require 'rails_helper'
RSpec.describe 'ActivityLog API', type: :request do
  describe "GET /index" do
    it "renders a successful response" do
      user = create :user, administrator: true
      login user

      get '/admin/activity_logs'

    end
  end
end
