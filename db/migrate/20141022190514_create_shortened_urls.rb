class CreateShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :long_url
      t.string :short_url
      t.integer :user_id
      
      t.timestamps
    end
    
    add_index :shortened_urls, :short_url, name: :submitter_id, unique: true
  end
end