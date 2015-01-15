require 'rails_helper'

RSpec.describe Story, :type => :model do
  before(:each) { @story = FactoryGirl.create(:story) }

  subject { @story }

  it { should respond_to(:title) }
  it { should validate_presence_of(:title) }
  it { should respond_to(:url) }
  it { should validate_presence_of(:url) }
  it { should respond_to(:tweet) }
  it { should validate_presence_of(:tweet) }
  it { should respond_to(:fb_post) }
  it { should validate_presence_of(:fb_post) }
  it { should respond_to(:publish_at) }
  it { should validate_presence_of(:publish_at) }
  it { should respond_to(:kinja_id) }
  it { should validate_presence_of(:kinja_id) }
  it { should validate_uniqueness_of(:kinja_id) }
  it { should respond_to(:domain) }
  it { should validate_presence_of(:domain) }

  it "#name returns a string" do
    expect(@story.title).to match 'This is a story'
  end

  it "creates from params" do
    story = Story.update_or_create({
      title: "You\"ll never guess what happens next",
      url: "http://example.com/foo",
      domain: 'example.com',
      tweet: "This is the tweet",
      fb_post: "This is the fb post",
      publish_at: DateTime.now,
      kinja_id: 1231242
    })
    expect(story.title).to eq "You\"ll never guess what happens next"
  end

  it "updates an existing post if it already exists" do
    Story.update_or_create({
      title: "You\"ll never guess what happens next",
      url: "http://example.com/foo",
      domain: 'example.com',
      tweet: "This is the tweet",
      fb_post: "This is the fb post",
      publish_at: DateTime.now,
      kinja_id: @story.kinja_id
    })
    expect(Story.where(kinja_id: @story.kinja_id).length).to eq 1
    expect(Story.find_by_kinja_id(@story.kinja_id).tweet).to eq "This is the tweet"
  end

  it "#published_stories returns stories that have published" do
    Story.update_or_create({
      title: "You\"ll never guess what happens next",
      url: "http://example.com/foo",
      domain: 'example.com',
      tweet: "This is the tweet",
      fb_post: "This is the fb post",
      publish_at: DateTime.now + 1.hour,
      kinja_id: @story.kinja_id
    })
    Story.update_or_create({
      title: "Ready to publish",
      url: "http://example.com/foo",
      domain: 'example.com',
      tweet: "This is the tweet",
      fb_post: "This is the fb post",
      publish_at: DateTime.now - 1.hour,
      kinja_id: @story.kinja_id
    })
    expect(Story.published_stories('example.com').length).to eq 1
    expect(Story.published_stories('example.com').first.title).to eq "Ready to publish"
  end

end
