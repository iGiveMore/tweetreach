class User < Neo4j::Rails::Model
  property :user_id, :type => String, :index => :exact
  property :screen_name, :type => String, :index => :exact
  property :name, :type => String
  property :profile_image_url, :type => String
  property :location, :type => String
  property :url, :type => String
  property :description, :type => String
  property :status_count, :type => String
  property :friends_count, :type => String
  property :followers_count, :type => String

  def self.find_or_create_from_auth_hash(hash)
    userinfo = hash["extra"]["raw_info"]

    user = User.find('screen_name: %s' % userinfo["screen_name"])

    if !user
      user = User.new

      user.user_id = userinfo['id_str']
      user.screen_name = userinfo['screen_name']
      user.name = userinfo['name']
      user.profile_image_url = userinfo['profile_image_url']
      user.location = userinfo['location']
      user.url = userinfo['url']
      user.description = userinfo['description']
      user.status_count = userinfo['status_count']
      user.friends_count = userinfo['friends_count']
      user.followers_count = userinfo['followers_count']

      user.save
    end

    return user
  end
end
