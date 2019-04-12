class ApplicationController < ActionController::Base
  include SessionsHelper

  class Forbidden < ActionController::ActionControllerError; end

  rescue_from Forbidden, with: :rescue403

  def rescue403(e)
    @exception = e
    render file: Rails.root.join('public/403.html'), status: 404, layout: false, content_type: 'text/html'
  end
end
