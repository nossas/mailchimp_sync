require 'factory_girl'

FactoryGirl.define do 

  factory :pdp_user, class: Pdp::User do
    email 'person@email.com'
    name  'some name'
  end

  factory :pdp_poke, class: Pdp::Poke do
    association :campaign, factory: :pdp_campaign 
    association :user, factory: :pdp_user 
    kind 'facebook'
  end

  factory :pdp_campaign, class: Pdp::Campaign do
    association :user, factory: :pdp_user
    name 'Sample'
    description 'Sample'
    category_id 14 
  end


end
