class StoriesController < ApplicationController
  protect_from_forgery with: :exception, :except => :create
  # before_action :authenticate_user!, only: [:create]

  def index
    @stories = Story.published_stories(params[:domain])
    @feed_type = params[:feed_type]
    @domain = params[:domain]

    respond_to do |format|
      format.html
      format.xml { render 'stories/feed.haml' }
    end
  end

  def create
    Story.update_or_create(story_params)
    render nothing: true
  end

  private
  def story_params
    params.permit(:title, :url, :kinja_id,
                  :publish_at, :tweet, :fb_post, :domain, :author)
  end

end
