class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.integer :kinja_id
      t.string :domain
      t.text :url
      t.text :author
      t.text :tweet
      t.text :fb_post
      t.datetime :publish_at
      t.boolean :set_to_publish, default: false

      t.timestamps null: false
    end
  end
end
