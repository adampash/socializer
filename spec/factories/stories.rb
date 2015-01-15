FactoryGirl.define do
  factory :story do
    title "This is a story"
    url "http://example.com/foo"
    domain "example.com"
    author "MyText"
    tweet "MyText"
    fb_post "MyText"
    kinja_id 1398029
    publish_at "2015-01-15 14:09:22"
  end

end
