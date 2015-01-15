class StoriesController < ApplicationController
  def index
    @stories = Story.published_stories(params[:domain])

    respond_to do |format|
      format.html
      # format.xml { render xml: @stories }
      # format.xml { render html: 'stories/feed.haml', content_type: "application/rss", stories: @stories }
      format.xml { render 'stories/feed.haml', stories: @stories }
    end
  end
end
