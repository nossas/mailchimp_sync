module Imagine 

  class User < Imagine::Database
 


    def name
      last_name.present? ? "#{first_name.capitalize} #{last_name.capitalize}" : first_name
    end
  end
end

