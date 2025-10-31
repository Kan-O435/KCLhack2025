module Api::V1
  class SessionsController < DeviseTokenAuth::SessionsController
    skip_after_action :update_auth_header, only: [:create]

    def create
      super
      if @resource
        token_headers = @resource.create_new_auth_token(request.headers['client'])
        token_headers.each do |k, v|
          response.headers[k.to_s] = v.to_s
        end
      end
    end
  end
end

