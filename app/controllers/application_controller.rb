class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Errors
  include ErrorActions

  HTTPResponseErrors.each do |code, status|
    class_eval <<-EOS
      rescue_from(#{code.to_s.camelize}) {|e| render_error e }
    EOS
  end
end
