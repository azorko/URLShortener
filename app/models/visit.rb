class Visit < ActiveRecord::Base
  validate :submitted_url_id, presence: true, unique: true
  validate :submitter_id, presence: true, unique: true
  
  def self.record_visit!(user, shortened_url)
      Visit.create!(
        :submitted_url_id => shortened_url.id,
        :submitter_id => user.id
      )

  end
  
  
  belongs_to(
    :submitted_url,
    :class_name => "ShortenedUrl",
    :foreign_key => :submitted_url_id,
    :primary_key => :id
  )
  
  belongs_to(
    :submitter,
    :class_name => "User",
    :foreign_key => :submitter_id,
    :primary_key => :id
  )
end