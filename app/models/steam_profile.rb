module SteamProfile
  def self.included(base)
    base.class_eval do
      include InstanceMethods
    end
  end
  
  module InstanceMethods
    
    def steam_friend_ids
      graph.get_connections('/me', 'friends').map{|h| h['id'].to_i}      
    end
    
    def steam_friends_with?(user)
      fb_friend_ids.include?(user.profile[:id])
    end
    
    def graph
      @graph ||= Koala::Facebook::API.new(facebook_authorization.token)
    end
        
    def steam?
      steam_authorization
    end    
    
    def steam_authorization
      self.authorizations.where(:provider => "steam").first
    end
    
  end
              
end