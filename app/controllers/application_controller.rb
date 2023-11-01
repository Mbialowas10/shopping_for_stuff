class ApplicationController < ActionController::Base
  def initialize_session
    # this will initialize the visit count to 0 for new users
    session[:visit_count] ||= 0
  end

  def increment_visit_count
    # this will inrement the user's visit count in the seesion
    session[:visit_count] += 1
  end

  def visit_count
    session[:visit_count]
  end

  session[:visit_count] += 1
  @visit_count = session[:visit_count]
end
