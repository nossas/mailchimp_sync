module Pdp

  class Campaign < Database

    
    self.table_name = 'campaigns'

    has_many :pokes
    has_many :pokers, -> { uniq }, through: :pokes, source: :user
    belongs_to :user


    scope :active, -> { where('accepted_at is not null') }



    def childs
      self.pokers 
    end
  end

end
