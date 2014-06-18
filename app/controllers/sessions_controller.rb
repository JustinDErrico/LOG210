class SessionsController < ApplicationController
def form
end
#Log in
#################################################################################
#Source:
#http://stackoverflow.com/questions/5056451/redirect-to-login-page-if-user-not-logged-in
#################################################################################
  skip_before_filter :require_login
def create
  client = Client.authenticate(params[:email], params[:password])
  if client
    session[:client_type] = client.clientType
    session[:client_id] = client.id
    redirect_to '/clients/'+ client.id.to_s(), :notice => "Logged in!"
  else
    respond_to do |format|
      format.html { redirect_to new_session_path,:notice => "Invalid credentials" }
    end

  end
end
#Logout
def destroy
  session[:client_id] = nil
  session[:client_type] = client.clientType
  redirect_to root_url, :notice => "Logged out!"

end
end
