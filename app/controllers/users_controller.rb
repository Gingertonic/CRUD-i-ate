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
      flash[:signup_error] = "Uh oh! You left some fields empty. Please fill in all fields."
      redirect to '/signup'
    else
      flash[:signup_success] = "Thanks for signing up!"
      @user = User.create(params[:user])
      session[:user_id] = @user.id
      redirect to '/'
    end
  end

  get '/login' do
      if logged_in?
        redirect to '/'
      else
        erb :'/users/login'
      end
    end

    post '/login' do
      @user = User.find_by(username: params[:user][:username])
      if @user && @user.authenticate(params[:user][:password])
        flash[:login_success] = "Welcome, #{@user.username.capitalize}"
        session[:user_id] = @user.id
        redirect to '/'
      else
        flash[:login_error] = "The login or password entered is invalid"
        redirect to '/login'
      end
    end

    get '/logout' do
      flash[:logout_success] = "Logged out successfully"
      session.clear
      redirect to '/'
    end
  end
