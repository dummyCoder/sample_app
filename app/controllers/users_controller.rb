class UsersController < ApplicationController

  before_filter :signed_in_user, :only => [:edit, :update, :index, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => [:destroy]
  before_filter :non_signed_in_user, :only => [:new, :create]

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
  end

  def update
    if( @user.update_attributes(params[:user]) )
      # Handle a successful update.
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(:page => params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  private

  def signed_in_user
    if (!signed_in?)
      store_location
      redirect_to signin_path, :notice => "Please sign in first."
    end
  end

  def correct_user
    @user = User.find(params[:id])
    if(!current_user?(@user))
      flash[:error] = "You do not have access to this action."
      redirect_to root_path
    end
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  def non_signed_in_user
    if signed_in?
      flash[:error] = "You should sign out first."
      redirect_to root_path
    end
  end

end
