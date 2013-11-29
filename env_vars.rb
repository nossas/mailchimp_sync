if ENV['PDP'] == nil and ENV['RACK_ENV'] != 'production'

  ENV['PDP'] = 'postgres://luizfonseca:@localhost/seurio_development'

  # Verdade ou Consequencia 
  ENV['VOC'] = 'postgres://luizfonseca:@localhost/voc_development'

  # Meu Rio, Blazing flower
  ENV['MR'] = 'postgres://luizfonseca:@localhost/meu_rio_development'

  # De guarda 
  ENV['DEGUARDA'] = 'postgres://luizfonseca:@localhost/deguarda_development'

  # Imagine 
  ENV['IMAGINE'] = 'postgres://luizfonseca:@localhost/imagine_development'

  # Faca Acontecer
  ENV['APOIE'] = 'postgres://luizfonseca:@localhost/crowdfunding_development'

  # De Olho
  ENV['DEOLHO']  = 'postgres://luizfonseca:@localhost/deolho_development'

  # Local
  ENV['DATABASE_URL'] = 'postgres://luizfonseca:@localhost/member_sync_development'

  # Mailchimp relative
  ENV['LIST_ID']            = "YOUR_LIST_ID" # d0450fcc54
  ENV['MAILCHIMP_API_KEY']  = "YOUR_KEY" # 5ad1480082ef9b63e682b76f08ed3358-us7
  ENV['MAILCHIMP_API_URL']  = "API_URL" #https://us6.api.mailchimp.com/1.3/

end
