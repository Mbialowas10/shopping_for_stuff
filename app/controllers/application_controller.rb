class ApplicationController < ActionController::Base
  before_action :initialize_session, :increment_visit_count
  helper_method :visit_count

  private

  def initialize_session
    # this will initialize the visit count to zero for new users.
    # default value when the thing on the left hand side is UNSET, when nil set to 0
    session[:visit_count] ||= 0
  end

  def increment_visit_count
    # this will increment the user's visit count in session.
    session[:visit_count] += 1
  end

  def visit_count
    # this will return the visit count from session.
    session[:visit_count]
  end
end
