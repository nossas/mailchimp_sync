module Pdp
  class User < Database 

    has_many :campaigns
    has_many :pokes
    has_many :poked_campaigns, -> { uniq }, through: :pokes, source: :campaign

    def poked
      self.poked_campaigns.map(&:name)
    end

  end
end
