class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :set_paper_trail_whodunnit

  protected
  def user_for_paper_trail
    admin_user_signed_in? ? current_admin_user.id : 'Unknown'
  end
end
