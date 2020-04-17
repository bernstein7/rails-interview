module API
  class ApplicationController < ActionController::API
    before_action :authenticate

    def authenticate
      # Here we might wanna check Bearer token or JWT
    end
  end
end
