class Story < ActiveRecord::Base
  # attr_accessible :title, :url, :publish_at, :tweet, :fb_post, :domain
  validates_presence_of :title, :url, :kinja_id,
    :publish_at, :domain, :author
  validates_uniqueness_of :kinja_id
  validates_inclusion_of :set_to_publish, :in => [true, false]

  def self.update_or_create(params)
    story = find_by_kinja_id params[:kinja_id]
    return create params if story.nil?
    story.update params
    story
  end

  def self.published_stories(domain, network="twitter")
    network == 'twitter' ? attr = 'tweet' : attr = 'fb_post'
    delay = 200.seconds
    where(domain: domain).where(set_to_publish: true).where("publish_at <= :now", now: DateTime.now - delay).where.not(attr => "").order('publish_at DESC').limit(20)
  end
end
