module ZoomClient
  ZOOM_PATH = "https://api.zoom.us/v2/users/#{Rails.application.credentials.zoom[:user_id]}/meetings"

  class << self
    def generate_url(**params)
      uri = URI.parse(ZOOM_PATH)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      req = Net::HTTP::Post.new(uri.path)
      req.body = payload(params)

      req.initialize_http_header(headers)

      res = http.request(req)

      JSON.parse(res.body)['join_url']
    end

    private

    def payload(**params)
      {
        topic: params[:topic],
        type: '1',
        duration: params[:duration],
        timezone: "Asia/Tokyo",
        password: "",
        agenda: params[:agenda]
      }.to_json
    end

    def headers
      {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{generate_jwt}"
      }
    end

    def generate_jwt
      payload = {
       iss: Rails.application.credentials.zoom[:api_key],
       exp: Time.now.to_i + 36000
      }

      JWT.encode(payload, Rails.application.credentials.zoom[:api_secret], 'HS256')
    end
  end
end
