require './application'
require './lib/segment'
require './lib/batch'
require 'active_record'
require 'sinatra/activerecord/rake'

API_KEY = ENV['MAILCHIMP_API_KEY'] 
API_URL = ENV['MAILCHIMP_API_URL'] 
LIST_ID = ENV['LIST_ID'] 

desc "run irb console"
task :console, :environment do |t, args|
  ENV['RACK_ENV'] = args[:environment] || 'development'

  exec "irb -r irb/completion -r ./application.rb"
end




# Registered platforms:
# pdp, mr, apoie, imagine, voc, deguarda, deolho
task :sync_users, :environment do |t, args|
  platform = ENV['platform'].present? ? ENV['platform'].to_sym : :pdp
  puts Batch.send_batch(Batch.load_users_batch(platform)) if has_new_users?(platform) 
  Segment.platform_segment_add(platform, Batch.load_users_batch(platform, segment: true)) if has_new_users?(platform)
end



# Registered platforms:
# pdp, mr
task :sync_campaigns, :environment do |t, args|
  platform = ENV['platform'].present? ? ENV['platform'].to_sym : :pdp
  campaigns_sync!(platform, campaign_module(platform))
end


def campaigns_sync!(platform, object)
  if has_new_campaigns?(platform)
    object.active.find_each do |campaign|
      response = Segment.create_segment(platform, campaign.name)

      puts Segment.send_segment_member_batch(
        Batch.load_campaigns_users_batch(campaign), { seg_id: response.to_i}
      )
    end
  end
  sync_platform(platform)
end

def sync_platform(platform)
  Sync::Platform.new do |s|
    s.platform  = platform.to_s 
    s.synced_at = Time.now
    s.save!
  end
end



# Trying to guess which User Module we should load when making comparisons
# Every platform has its own user module
def user_module(platform = :pdp)
  case platform
  when :pdp       then Pdp::User
  when :mr        then Mr::User
  when :imagine   then Imagine::User
  when :voc       then Voc::User
  when :apoie     then Apoie::User
  when :deguarda  then DeGuarda::User
  when :deolho    then DeOlho::User
  end
end


def campaign_module(platform = :pdp)
  case platform
  when :pdp then Pdp::Campaign
  when :mr then Mr::Campaign
  end
end


# Method to check if the given user module has updated users
# Ex.: Pdp::User may have new users and etc.
def has_new_users?(platform = :pdp)
  user      = user_module(platform).last_updated
  platform  = Sync::Platform.last_synced(platform)

  return true if platform.nil?
  return user > platform if user and platform
  return false
end


# Method to check if the given campaign module (can be an issue from MR too) has updated campaigns
# Currently only Pdp is supported
def has_new_campaigns?(platform = :pdp)
  campaign = campaign_module(platform).last_updated
  platform = Sync::Platform.last_synced(platform)

  return true if platform.nil?
  return campaign > platform if campaign and platform
  return false
end

















