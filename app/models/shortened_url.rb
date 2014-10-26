require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  validate :long_url, presence: true, unique: true, limit: 1024 ####
  validate :no_more_than_five_urls
  validate :short_url, unique: true
  validate :user_id, presence: true, unique: true
  
  def self.random_code
    rand = ""
    
    loop do 
     rand = SecureRandom.urlsafe_base64
     break unless ShortenedUrl.exists?(short_url: rand)
    end
   
     rand
  end
  
  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(
      short_url: ShortenedUrl.random_code,
      long_url: long_url,
      user_id: user.id
    )
  end
  
  def num_clicks
    Visit.where("submitted_url_id = ?", self.id).count
  end
  
  def num_uniques
    self.visitors.count
  end
  
  def num_recent_uniques
    Visit.where('updated_at > ?', 10.minutes.ago).distinct.count
  end
  
  belongs_to(
    :submitter,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id
  )
  
  has_many(
    :visitors,
    -> { distinct },
    :through => :visits,
    :source => :submitter
  )
  
  has_many(
    :visits,
    :class_name => "Visit",
    :foreign_key => :submitted_url_id,
    :primary_key => :id
  )
  
  
  has_many(
    :taggings,
    :class_name => "Tagging",
    :foreign_key => :shortened_url_id,
    :primary_key => :id
  )
  
  has_many(
    :tag_topics,
    :through => :taggings,
    :source => :tag_topic
  )
  
  
  private
  def no_more_than_five_urls
    
    if self.submitter.submitted_urls.select { |url| url.created_at > 1.minutes.ago }.count > 5
      errors[:long_url] << "Can't submit more than 5 url's in a minute!"
    end
  end
end
