module Batch
  
  class << self 
    # Method to just send or break a batch
    def send_batch(batch)
      response = batch.size > 2000 ? break_and_send_batch(batch) : batch_subscribe(batch)
      return response
    end


    # Method to post data using HTTParty and a simple post action.
    def post_data(url, data)
      response = HTTParty.post(url, data)
      return response
    end



    # method to break a batch in pieces of 10_000 records and send them
    def break_and_send_batch(batch, segment = false, options = {})

      puts "Breaking the batch into pieces"
      new_batch = []
      counter   = 1
      while new_batch.size != batch.size

        # We are creating a new list with 2000 itens, based on the new batch
        # Ex.: new_batch now is 0, so we are going to take the batch[0..2000] itens
        list =  batch[(new_batch.size)..(new_batch.size + 2000)]

        # Printing the current_status
        puts "List is now #{list.size}. The list is a segment? #{segment == true}. The first email is #{list.first}"
        puts "List is now being subscribed to #{options}"

        # Batch subscribing
        subscribe = segment == true ? batch_segment_subscribe(list, options) : batch_subscribe(list, options)

        puts subscribe

        # The new list has 2001 members, so we must add them to the new batch.
        new_batch = new_batch + list 

        puts "Batch n. #{counter} sent. Batch is now with #{new_batch.size} elements."
        counter   += 1


      end
    end


    # Batch options that should be present when sending the batch.
    # API KEY is mandatory
    def load_batch_options(batch, options = {})
      options = { 
        body: { 
          apikey: API_KEY, id: LIST_ID, batch: batch, 
          double_optin: false, update_existing: true 
        }.merge(options)           
      }
    end



    # Method to Batch subscribe... a batch of users :)
    def batch_subscribe(batch, options = {})
      url       = API_URL + '?method=listBatchSubscribe'
      response  = post_data(url, load_batch_options(batch, options))

      puts "Batch sent: #{response}"
    end

    def batch_segment_subscribe(batch, options)
      url       = API_URL + '?method=listStaticSegmentMembersAdd' 
      response  = Batch.post_data(url, Segment.load_batch_segment_options(batch, options))

      puts "Batch sent: #{response}"
    end




    # Prepare a batch with all users from the given platform/user module
    def load_users_batch(platform = :pdp, segment: false)
      batch     = []
      last_sync = Sync::Platform.last_synced(platform)
      scope     = user_module(platform)
      users     = last_sync.nil? ? scope : scope.where('updated_at < ?', last_sync)

      users.find_in_batches(batch_size: 2000) do |user_batch|
        user_batch.each do |u|

          batch << { "EMAIL" => u.email, "FNAME" => u.name } if segment == false
          batch << u.email if segment == true
        end
        puts "Batch is now #{batch.length} big."
      end

      return batch
    end

    def load_campaigns_users_batch(campaign)
      batch = []
      campaign.childs.find_in_batches(batch_size: 2000) do |user_batch|
        user_batch.each do |u|
          batch << u.email
        end

        puts "Campaign User Batch is now #{batch.length} big."
      end

      return batch
    end
  end
end
