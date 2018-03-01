
class PostsController < ApplicationController


    # Create
  get '/posts/new' do
    @user = User.find(session[:user_id])
    @posts = Post.all
    erb :'/posts/new'
  end



  post '/posts' do
    if blank_params?("post")
      flash[:new_error] = "One or more fields were left empty. Please fill in all fields."
      redirect to '/posts/new'
    else
      flash[:new_success] = "Your post has been added to the list."
      @post = Post.create(params[:post])
      redirect to "/posts/#{@post.slug}"
    end
  end

  # Read
   get '/posts' do
     @posts = Post.all
     erb :'/posts/index'
   end

   get '/posts/:slug' do
     @post = Post.find_by_slug(params[:slug])
     erb :'/posts/show'
   end
   # Update
    get '/posts/:slug/edit' do
      @post = Post.find_by_slug(params[:slug])

      if !logged_in?
        flash[:not_logged_in_edit] = "You need to login to edit posts"
        redirect to "/login"
      elsif @post.user_id == current_user.id
        flash[:edit_success] = "Thanks for updating this post"
        erb :'/posts/edit'
      else
        flash[:edit_error] = "You are only able to edit your own posts"
        redirect to "/posts/#{@post.slug}"
      end
    end

    patch '/posts/:slug' do
      @post = Post.find_by_slug(params[:slug])

      if blank_params?("post")
        flash[:update_error] = "One or more fields were left empty. Please fill in all fields."
        redirect to "/posts/#{@post.slug}/edit"
      else
        @post.update(params[:post])
        flash[:update_success] = "This post has been updated!"
        redirect to "/posts/#{@post.slug}"
      end
    end

    # Delete
    delete '/posts/:slug' do
      @post = Post.find_by_slug(params[:slug])

      if !logged_in?
        flash[:not_logged_in_delete] = "You need to login to delete posts"
        redirect to "/login"
      elsif @post.user_id == current_user.id
        flash[:delete_success] = "This post has been deleted"
        @activity.destroy
        redirect to "/posts"
      else
        flash[:delete_error] = "You are only able to delete your own posts"
        redirect to "/posts/#{@post.slug}"
      end
    end
  end
