class StoriesController < ApplicationController
  protect_from_forgery with: :exception, :except => [:create, :update_pub]
  before_action :authenticate_user!, only: [:create]

  def index
    @stories = Story.published_stories(params[:domain], params[:feed_type])
    @feed_type = params[:feed_type]
    @domain = params[:domain]

    respond_to do |format|
      format.html
      format.xml { render 'stories/feed.haml' }
    end
  end

  def create
    @story = Story.update_or_create(story_params)
    # render nothing: true
    render json: @story
  end

  def update_pub
    @story = Story.find_by_kinja_id(params[:kinja_id])
    unless @story.nil?
      @story = Story.update_or_create(story_params)
    else
      @story = false
    end
    render json: @story
  end

  def show
    @story = Story.find_by_kinja_id params[:kinja_id]

    respond_to do |format|
      format.html { render json: @story}
      format.json { render json: @story}
    end
  end

  private
  def story_params
    params.permit(:title, :url, :kinja_id,
                  :publish_at, :tweet, :fb_post,
                  :domain, :author, :set_to_publish)
  end

end
