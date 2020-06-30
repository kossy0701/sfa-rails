class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::MimeResponds
  include Errors
  include ErrorActions

  HttpResponseErrors.each do |code, _status|
    class_eval <<-RUBY
      rescue_from(#{code.to_s.camelize}) {|e| render_error e }
    RUBY
  end

  def ip_restriction!
    raise Unauthorized unless current_user
    raise Forbidden unless current_user.tenant.ips.blank? || current_user.tenant.ips.any? { |ip| ip.content.include?(IPAddress(request.remote_ip)) }
  end

  def current_user_tenant
    raise Unauthorized unless current_user

    current_user.tenant
  end
end
