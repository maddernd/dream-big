class ApplicationController < ActionController::API
  def headers
    request.headers
  end
end
