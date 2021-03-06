class StoryController < ActiveUsersController
  before_action :set_current_story, only: [:index, :about, :chapter]


  def index
  end

  def about
  end

  def choose
    @subscriptions = active_user.subscriptions.decorate.select { | sub | !sub.story.chapters.published.empty? }.sort_by {|s| s.story.completed? ? 0 : 1}
    @subscriptions.sort_by! { | s | s.story.updated_at }.reverse!
    @all_active_stories = Story.recently_completed_and_active.sort_by { |s| s.updated_at }
    @all_completed_stories = Story.all_completed.sort_by { |s| s.updated_at }
  end

  def full
    @story = Story.find_by_permalink(params[:permalink]).decorate
    @chapters = ChapterDecorator.decorate_collection(@story.chapters)
  end

  def set_current_story_id
    set_current_story_id_in_session
    redirect_to story_path
  end

  def story_chapter
    set_current_story_id_in_session
    redirect_to read_chapter_path(params[:number])
  end

  def chapter
    @active_user = active_user

    @subscription = active_user.subscriptions.find_by!(story: @current_story)
    @subscription.update(last_read_chapter_number: params[:number])
    @chapter = @current_story.chapters.find_by_number!(params[:number])
    Resque.enqueue(ViewableWorker, @chapter.id, active_user.id)
    @call_to_action = CallToActionDecorator.new(@chapter.call_to_action)
    @allow_voting = @subscription.allow_voting_for? @chapter
    @steps = {}
    @steps[:prev] = @chapter.number - 1 unless (@chapter.number - 1) < 1
    @steps[:next] = @chapter.number + 1 unless @current_story.chapters.first == @chapter
  end

  def latest
    set_current_story_id_in_session
    set_current_story
    chp_num = @current_story.chapters.published.last.number
    redirect_to read_chapter_path(chp_num)
  end

  private

  def set_current_story

    if session[:current_story_id]
      @current_story || @current_story = Story.find(session[:current_story_id])
    elsif session[:subscribed_stories].nil?
      flash[:message] = "you have not subscribed to any stories yet"
      redirect_to account_path
    else
      redirect_to choose_story_path
    end
  end

  def set_current_story_id_in_session
    session[:current_story_id] = params[:id] if params[:id]
    session[:current_story_id] = Story.find_by_permalink(params[:story]).id if params[:story]
  end
end
