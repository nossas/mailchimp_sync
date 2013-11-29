module Mr
  class CampaignSignatures < Mr::Database
  
    self.table_name = 'petition_signatures'
    
    belongs_to :user, foreign_key: :member_id
    belongs_to :campaign, foreign_key: :petition_id
  end

end

