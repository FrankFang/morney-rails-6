class SessionsController < ApplicationController
  def create
    s = Session.new create_params
    s.validate
    render_resource s
  end
  def destroy
  
  end

  def create_params
    params.permit(:email, :password)
  end
end
