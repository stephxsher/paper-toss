namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    [User, Location, Company].each(&:delete_all)
    
   Company.populate 1 do |company| 
     company.name = 'Flatiron school'   
      Location.populate 3 do |location|
        location.name = ["New York", "London", "Sidney"].shift
        location.company_id = company.id

        User.populate 100 do |user|
          
          i=rand(1..20)
          w=rand(1..3)
           
          user.encrypted_password = 'password'
          user.sign_in_count = 10
          user.first_name = Faker::Name.first_name
          user.last_name = Faker::Name.last_name
          user.email   = Faker::Internet.email
          user.location_id = location.id
          user.hire_date = Time.now - i.years
          user.karma = rand(1..50)
          user.time_zone = ["UTC", "GMT", "AEST"][w]
          user.department = ["Sales", "IT", "HR", "Finance", "Business Development", "Marketing"][i%6]
           
        end
      end
    end 
  end 

end