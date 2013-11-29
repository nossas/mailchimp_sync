module Mr
  class Campaign < Mr::Database
  
    self.table_name = 'petitions'
    
    has_many :users, through: :campaign_signatures, source: :user
    has_many :campaign_signatures, class_name: "CampaignSignatures", foreign_key: :petition_id



    def name
      self.title
    end

    def self.active
      self.where(state: ['published', 'archived'])
    end

    
    def childs
      self.users
    end
  end

end
