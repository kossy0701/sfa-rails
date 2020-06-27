module Errors
  # 4xx / 5xx errors
  HttpResponseErrors = {
    # code:                status
    bad_request: 400, # 400 BadRequest
    unauthorized: 401, # 401 Unauthorized
    forbidden: 403, # 403 Forbidden
    not_found: 404, # 404 NotFound
    method_not_allowed: 405, # 405 Method Not Allowed
    internal_server_error: 500 # 500 InternalServerError
  }.freeze

  # base of HttpResponseErrors class
  class HttpResponseError < StandardError
    attr_accessor :code, :message, :errors, :info

    def initialize(args = {})
      return unless args.is_a?(Hash)

      @code    = args[:code]
      @message = args[:message]
      @errors  = args[:errors]
      @info    = args[:info]
    end

    def capitalize_with_space(str, delimiter = '_')
      str.split(delimiter).map(&:capitalize).join(' ') if str.present?
    end
  end

  HttpResponseErrors.each do |code, status|
    class_eval <<-RUBY
      class #{code.to_s.camelize} < HttpResponseError
        def status
          HttpResponseErrors[:#{code}]
        end

        def code
          @code || "#{code}"
        end

        def message
          @message || ("#{status} " + capitalize_with_space("#{code}"))
        end
      end
    RUBY
  end
end
