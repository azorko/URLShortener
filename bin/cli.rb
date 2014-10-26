puts "Input your email:"
email = gets.chomp

user = User.where("email = ?", email)
if user.empty?
  user = User.create!(:email => email)
else
  user = user.first
end

puts "What do you want to do?"
puts "0. Create shortened URL"
puts "1. Visit shortened URL"
puts "2. Assign a tag topic"
ans = gets.chomp.to_i

case ans
when 0
  puts "Type in your long url"
  long_url = gets.chomp
  short_url = ShortenedUrl.create_for_user_and_long_url!(user, long_url).short_url
  puts "Short url is: #{short_url}"
when 1
  puts "Type in the shortened URL"
  short_url = gets.chomp
  url = ShortenedUrl.where('short_url = ?', short_url).first
  Launchy.open(url.long_url)
  Visit.record_visit!(user, url)
when 2
  puts "Type in your long url"
  long_url = gets.chomp
  puts "Choose a tag topic: (news), (sports), (music)"
  ans = gets.chomp
  tag_topic = TagTopic.create!(:topic => ans)
  p tag_topic
  short_url = ShortenedUrl.where("long_url = ?", long_url).first
  p short_url
  Tagging.create!(:tag_topic_id => tag_topic.id, :shortened_url_id => short_url.id)
end