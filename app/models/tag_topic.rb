class TagTopic < ActiveRecord::Base
  
  CATEGORIES = ["news", "sports", "music"]
  
  has_many(
    :taggings,
    :class_name => "Tagging",
    :foreign_key => :tag_topic_id,
    :primary_key => :id
  )
  
  has_many(
    :shortened_urls,
    :through => :taggings,
    :source => :shortened_url
  )
  
  def most_popular_tag
    popularity = Hash.new(0)
    CATEGORIES.each do |topic|
     shortened_urls
      tags_of_type = TagTopic.where("topic = ?", topic)
      
      tags_of_type.each do |tag|
        popularity[short_url_id] += tag.shortened_urls.count
      end
    end
  end
  
end