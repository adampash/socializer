require 'rails_helper'

RSpec.describe Story, :type => :model do
  before(:each) { @story = FactoryGirl.create(:story) }

  subject { @story }

  it { should respond_to(:title) }
  it { should validate_presence_of(:title) }
  it { should respond_to(:author) }
  it { should validate_presence_of(:author) }
  it { should respond_to(:url) }
  it { should validate_presence_of(:url) }
  it { should respond_to(:tweet) }
  # it { should validate_presence_of(:tweet) }
  it { should respond_to(:fb_post) }
  # it { should validate_presence_of(:fb_post) }
  it { should respond_to(:publish_at) }
  it { should validate_presence_of(:publish_at) }
  it { should respond_to(:kinja_id) }
  it { should validate_presence_of(:kinja_id) }
  it { should validate_uniqueness_of(:kinja_id) }
  it { should respond_to(:domain) }
  it { should validate_presence_of(:domain) }
  it { should respond_to(:set_to_publish) }

  it "#name returns a string" do
    expect(@story.title).to match 'This is a story'
  end

  it "creates from params" do
    story = Story.update_or_create({
      title: "You\"ll never guess what happens next",
      author: "Me",
      url: "http://example.com/foo",
      domain: 'example.com',
      tweet: "This is the tweet",
      fb_post: "This is the fb post",
      publish_at: DateTime.now,
      kinja_id: 1231242,
      set_to_publish: false
    })
    expect(story.title).to eq "You\"ll never guess what happens next"
  end

  it "updates an existing post if it already exists" do
    Story.update_or_create({
      title: "You\"ll never guess what happens next",
      author: "Me",
      url: "http://example.com/foo",
      domain: 'example.com',
      tweet: "This is the tweet",
      fb_post: "This is the fb post",
      publish_at: DateTime.now,
      kinja_id: @story.kinja_id,
      set_to_publish: false
    })
    expect(Story.where(kinja_id: @story.kinja_id).length).to eq 1
    expect(Story.find_by_kinja_id(@story.kinja_id).tweet).to eq "This is the tweet"
  end

  it "#published_stories returns stories post publish time set to publish" do
    Story.update_or_create({
      title: "Not ready to publish b/c it's in the future",
      author: "Me",
      url: "http://example.com/foo",
      domain: 'example.com',
      tweet: "This is the tweet",
      fb_post: "This is the fb post",
      publish_at: DateTime.now + 1.hour,
      kinja_id: 1290233,
      set_to_publish: true
    })
    Story.update_or_create({
      title: "Ready to publish",
      author: "Me",
      url: "http://example.com/foo",
      domain: 'example.com',
      tweet: "This is the tweet",
      fb_post: "This is the fb post",
      publish_at: DateTime.now - 1.hour,
      kinja_id: 12902333,
      set_to_publish: true
    })
    Story.update_or_create({
      title: "Not set to publish",
      author: "Me",
      url: "http://example.com/foo",
      domain: 'example.com',
      tweet: "This is the tweet",
      fb_post: "This is the fb post",
      publish_at: DateTime.now - 1.hour,
      kinja_id: 2348390,
      set_to_publish: false
    })
    expect(Story.published_stories('example.com').length).to eq 1
    expect(Story.published_stories('example.com').first.title).to eq "Ready to publish"
  end

  it "#published_stories only returns stories with content per domain" do
    Story.update_or_create({
      title: "Not ready to publish b/c it's in the future",
      author: "Me",
      url: "http://example.com/foo",
      domain: 'example.com',
      tweet: "",
      fb_post: "This is the fb post",
      publish_at: DateTime.now - 1.hour,
      kinja_id: 1290233,
      set_to_publish: true
    })
    Story.update_or_create({
      title: "Ready to publish",
      author: "Me",
      url: "http://example.com/foo",
      domain: 'example.com',
      tweet: "This is the tweet",
      fb_post: "This is the fb post",
      publish_at: DateTime.now - 1.hour,
      kinja_id: 12902333,
      set_to_publish: true
    })
    expect(Story.published_stories('example.com', 'twitter').length).to eq 1
    expect(Story.published_stories('example.com').first.tweet).to eq "This is the tweet"
  end

end
