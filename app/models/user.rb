class User < Neo4j::Rails::Model
  property :user_id, :type => String
  property :screen_name, :type => String
  property :name, :type => String
  property :profile_image_url, :type => String
  property :location, :type => String
  property :url, :type => String
  property :description, :type => String
  property :status_count, :type => String
  property :friends_count, :type => String
  property :followers_count, :type => String
end
