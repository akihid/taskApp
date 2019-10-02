class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_current_user, if: :logged_in?

  class Forbidden < ActionController::ActionControllerError; end

  rescue_from Forbidden, with: :rescue403

  def rescue403(e)
    @exception = e
    render file: Rails.root.join('public/403.html'), status: 404, layout: false, content_type: 'text/html'
  end

  def set_current_user
    User.current_user = current_user
  end
end
