class Story < ActiveRecord::Base
  # attr_accessible :title, :url, :publish_at, :tweet, :fb_post, :domain
  validates_presence_of :title, :url, :kinja_id,
    :publish_at, :domain, :author
  validates_uniqueness_of :kinja_id

  def self.update_or_create(params)
    story = find_by_kinja_id params[:kinja_id]
    return create params if story.nil?
    story.update params
    # return story unless story.nil?
    # create params
  end

  def self.published_stories(domain)
    where(domain: domain).where("publish_at <= :now", now: DateTime.now)
  end
end
