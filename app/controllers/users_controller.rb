class UsersController < ApplicationController


  get '/signup' do
     if logged_in?
       flash[:existing_user_error] = "You're already signed up and logged in"
       direct to '/'
     else
       erb :'/users/signup'
     end
   end

   post '/signup' do
    if blank_params?("user")
      flash[:signup_error] = "One or more fields were left empty. Please fill in all fields."
      redirect to '/signup'
    else
      flash[:signup_success] = "Thanks for signing up!"
      @user = User.create(params[:user])
      session[:user_id] = @user.id
      redirect to '/'
    end
  end

end
