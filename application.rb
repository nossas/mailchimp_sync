require 'sinatra/activerecord'
require 'sinatra'
require 'mailchimp'
require 'httparty'

require './env_vars'
require './models/user'
require './models/pdp/database'
require './models/pdp/user'
require './models/pdp/poke'
require './models/pdp/campaign'
require './models/mr/database'
require './models/mr/user'
require './models/mr/campaign'
require './models/mr/campaign_signatures'
require './models/apoie/database'
require './models/apoie/user'
require './models/voc/database'
require './models/voc/user'
require './models/imagine/database'
require './models/imagine/user'
require './models/deguarda/database'
require './models/deguarda/user'
require './models/deolho/database'
require './models/deolho/user'


set :database, ENV['DATABASE_URL']
