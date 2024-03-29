class User < ActiveRecord::Base
  validate :email, presence: true, unique: true
  
  has_many(
    :submitted_urls,
    :class_name => "ShortenedUrl",
    :foreign_key => :user_id,
    :primary_key => :id
  )
  
  has_many(
    :visited_urls,
    -> { distinct },
    :through => :visits,
    :source => :submitted_url
  )
  
  has_many(
    :visits,
    :class_name => "Visit",
    :foreign_key => :submitter_id,
    :primary_key => :id
  )

  
end
