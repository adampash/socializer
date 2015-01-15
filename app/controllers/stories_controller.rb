class StoriesController < ApplicationController
  def index
    @stories = Story.published_stories(params[:domain])
    @feed_type = params[:feed_type]

    respond_to do |format|
      format.html
      # format.xml { render xml: @stories }
      # format.xml { render html: 'stories/feed.haml', content_type: "application/rss", stories: @stories }
      format.xml { render 'stories/feed.haml' }
    end
  end
end
