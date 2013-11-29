module Pdp

  class Poke < Database

    self.table_name = 'pokes'
    
    belongs_to :campaign
    belongs_to :user

    


  end

end
