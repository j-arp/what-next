class AccountController < ActiveUsersController
  before_action :require_login, except: [:login, :process_login, :callback]

  def index
    @user = active_user
    @available_stories = active_user.available_stories
    @subscriptions = active_user.subscriptions
    @authored_stories = active_user.authored_stories
    @most_recent_story = @authored_stories.sort_by {|s| s.updated_at}.reverse.first
    @other_authored_stories = active_user.authored_stories.select{ |st| st.id != @most_recent_story.id }
    @story = Story.new
    get_users
  end

  def login
  end

  def info_from_the_google
    {
      email: request.env["omniauth.auth"][:info][:email],
      first_name: request.env["omniauth.auth"][:info][:first_name],
      last_name: request.env["omniauth.auth"][:info][:last_name],
      image: request.env["omniauth.auth"][:info][:image]
    }

  end

  def callback
    info = info_from_the_google
    @user = User.where(email: info[:email]).first_or_initialize
    @user.first_name = info[:first_name]
    @user.last_name = info[:last_name]
    @user.image = info[:image]
    @user.last_login_at = Time.now
    @user.save

    if @user
      set_session(@user)
      flash[:message] = 'You have been logged in'

        if cookies["return_to"]
          redirect_to cookies["return_to"]
          cookies["return_to"] = nil
        else
          if @user.stories.present?
             redirect_to choose_story_path
           else
             redirect_to account_path
           end
        end

    else
      redirect_to login_path
    end
  rescue => e
    puts e
    flash[:message] = "Login could not be processed. Please try again."
    redirect_to login_path

  end

  def set_session(user)
    session[:user_id] = user.id
    session[:managed_story_id] = user.authored_stories.first.id if user.authored_stories.any?
    session[:current_story_id] = user.stories.first.id if user.stories.any?
    session[:subscribed_stories] = user.stories

    user.stories.any? ? session[:subscribed_stories] = user.stories.map(&:id) : []
  end

  def process_login
     user = User.find_by(email: params[:email])

     if user
      set_session(user)
      flash[:message] = 'You have been logged in'
      redirect_to account_path

    else
      flash[:message] = 'Nope!'
      redirect_to login_path
    end

  end

  def logout
    session[:user_id] = nil
    session[:managed_story_id] = nil
    session[:current_story_id] = nil
    session[:subscribed_stories] = nil
    flash[:message] = "You have been logged out"
    redirect_to login_path
  end

  private

  def get_users
    @active_user = active_user
    @users || @users = User.all
  end
end
