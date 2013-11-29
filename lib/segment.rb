module Segment
  
  class << self 
    def platform_segment_add(platform, batch)
      sync    = find_segment("[#{platform.to_s.upcase}] Todos os membros").first
      segment = sync.present? ? sync.seg_id : create_segment(platform, 'Todos os membros')
      send_segment_member_batch(batch, { seg_id: segment.to_i })
    end
  

    def find_segment(name)
      Sync::Segment.where(name: name).limit(1)
    end

    def save_segment(platform = :pdp, options = {})
      puts options.inspect
      Sync::Segment.new do |s|
        s.name        = options[:name]
        s.seg_id      = options[:seg_id]
        s.campaign_id = options[:campaign] || nil
        s.save!
      end
    end


    
    def send_segment_member_batch(batch, options)
      response = batch.size > 2000 ? Batch.break_and_send_batch(batch, true, options) : Batch.batch_segment_subscribe(batch, options)
      return response
    end
   



    def list_segments
      url = API_URL + '?method=listStaticSegments'
      response = Batch.post_data(url, { body: { apikey: API_KEY, id: LIST_ID } })
      return response
    end



    # Method to create Static Segments
    def create_segment(platform, segment, options = {}) 
      url         = API_URL + '?method=listStaticSegmentAdd'
      seg_options = load_new_segment_options(platform, segment)
      response    = Batch.post_data(url, seg_options)
     
      puts "Segment n. #{response}"
      puts seg_options[:body][:name]

      save_segment(platform, { name: seg_options[:body][:name], seg_id: response.body.to_i }) unless response.body['error']

      return find_segment(seg_options[:body][:name]).first.seg_id if response.body['error']
      return response
    end


    # Segment options when creating a new segment
    def load_new_segment_options(platform, segment, options = {})
      options = { body: { apikey: API_KEY, id: LIST_ID, name: "[#{platform.to_s.upcase}] " + segment }.merge(options) }
    end
    
    
    def load_batch_segment_options(batch, options = {})
      options = { body: { apikey: API_KEY, id: LIST_ID, batch: batch }.merge(options) } 
    end
  end
end
