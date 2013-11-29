module Apoie
  class Database < ActiveRecord::Base

    @db = URI.parse(ENV['APOIE'])

    self.establish_connection(
      adapter:  @db.scheme == 'postgres' ? 'postgresql' : database.scheme,
      host:     @db.host,
      username: @db.user,
      password: @db.password,
      database: @db.path[1..-1],
      encoding: 'utf8'
    )

    self.table_name = 'users'


    def self.last_updated
      selfie = self.order('updated_at desc').first
      return false unless selfie.present?
      return selfie.updated_at
    end

  end
end
