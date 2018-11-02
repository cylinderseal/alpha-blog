class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, except: [:index, :show]
  before_action :require_admin, only: [:destroy]
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Alpha Blog #{@user.username}!"
      redirect_to @user
    else
      render 'new' 
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  
  def destroy
    @user.destroy
    flash[:danger] = "User and all articles created have been deleted"
    redirect_to users_path
  end
  
  private
  
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
    
    def set_user
      @user = User.find(params[:id])
    end
    
    def require_same_user
      if current_user != @user && !current_user.admin?
        flash[:danger] = "You can only edit your own account"
        redirect_to root_path
      end
    end
    
    def require_admin
      if logged_in? && !current_user.admin?
        flash[:danger] = "You need to be an admin"
        redirect_to root_path
      end
    end
end
