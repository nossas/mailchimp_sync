module Sync
  class User < ActiveRecord::Base
  end


  class Platform < ActiveRecord::Base
    self.table_name = 'syncs'
    

    def self.last_synced(platform = :pdp)
     platform =  self.where(platform: platform).order('synced_at desc')
     return nil unless platform.present?
     return platform.first.synced_at
    end
  end


  class Segment < ActiveRecord::Base
    self.table_name = 'segments'



  end
end
