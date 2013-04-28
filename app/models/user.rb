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
  property :oauth_token, :type => String
  property :oauth_secret, :type => String

  has_n(:follows).to(User)

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
      user.oauth_token = hash["credentials"]["token"]
      user.oauth_secret = hash["credentials"]["secret"]

      user.save

      client = erik = Twitter::Client.new(
        :oauth_token => user.oauth_token,
        :oauth_token_secret => user.oauth_secret
      )

      # friends = Twitter.friends
      # followers = Twitter.followers

      # friends.each do |account|
      #   puts account.screen_name

      #   u = User.find_or_create_from_twitter(account)

      #   user.outgoing(:follows) << u

      #   break
      # end
    end

    return user
  end

  def self.find_or_create_from_twitter(account)
    user = User.find('screen_name: %s' % account.screen_name)

    if !user
      user = User.new

      # user.user_id = account.id
      user.screen_name = account.screen_name
      user.name = account.name
    end

    user.profile_image_url = account.profile_image_url
    user.location = account.location
    user.url = account.url
    user.description = account.description
    user.status_count = account.status_count
    user.friends_count = account.friends_count
    user.followers_count = account.followers_count

    user.save

    return user
  end
end
