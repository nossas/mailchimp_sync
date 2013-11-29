module Mr 
  class User < Mr::Database 

    has_many :campaigns
    
    self.table_name = 'members'



    def name
      "#{first_name.capitalize} #{last_name.capitalize}"
    end
  end
end

