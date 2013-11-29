require 'spec_helper'

describe Pdp::User do


  describe "#sync" do

  end


  describe "#poked" do
    before do
      @user      = FactoryGirl.create(:pdp_user) 
      @campaign  = FactoryGirl.create(:pdp_campaign)
    end

    context "when the user has 1 poked campaign" do
      before { @poke = FactoryGirl.create(:pdp_poke, campaign_id: @campaign.id, user_id: @user.id) }

      subject  { @user.poked }

      it "should return an hash with the campaign name" do
        expect(subject).to eq([@campaign.name])
      end
    end


    context "when the user has 2 poked campaign" do
      before do 
        @campaign_2 = FactoryGirl.create(:pdp_campaign)
        @poke_2     = FactoryGirl.create(:pdp_poke, campaign_id: @campaign_2.id, user_id: @user.id)
      end

      subject  { @user.poked }

      it "should return an hash with the campaigns name" do
        expect(subject).to eq([ @campaign.name, @campaign_2.name ])
      end
    end

    context "when the user has 0 poked campaign" do
      subject  { @user.poked }

      it "should return an empty hash" do
        expect(subject).to eq([])
      end
    end
  end




end
