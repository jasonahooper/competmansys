# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
@user = User.create!(:email => 'jason.hooper@talk21.com', :password => 'password',
  :roles_mask => 3, :first_name => 'Jason', :last_name => 'Hooper')

@comp = Competition.create!(:name => 'Archery Test', :description => 'An Archery Competition',
  :start_date => '2014-1-1', :end_date => '2014-1-1', :registration_close_date => '2014-1-1',
  :image => open("app/assets/images/bangalore.jpg"), :location => 'Bangalore, India',
  :user_id => @user.id)

Event.create!(:name => 'Recurve', :description => 'Recurve', :competition_id => @comp.id)
Event.create!(:name => 'Compound', :description => 'Compound', :competition_id => @comp.id)
Event.create!(:name => 'Team Recurve', :description => 'Team Recurve', :competition_id => @comp.id)
Event.create!(:name => 'Team Compound', :description => 'Team Compound', :competition_id => @comp.id)

@comp = Competition.create!(:name => 'Athletics Test', :description => 'An Athletics Competition',
  :start_date => '2014-2-1', :end_date => '2014-2-1', :registration_close_date => '2014-2-1',
  :image => open("app/assets/images/birmingham.jpg"), :location => 'Alexandra Stadium, Birmingham, England',
  :user_id => @user.id)

Event.create!(:name => '100m', :description => '100m', :competition_id => @comp.id)
Event.create!(:name => '200m', :description => '200m', :competition_id => @comp.id)
Event.create!(:name => '400m', :description => '400m', :competition_id => @comp.id)
Event.create!(:name => '800m', :description => '800m', :competition_id => @comp.id)
Event.create!(:name => '1500m', :description => '1500m', :competition_id => @comp.id)
Event.create!(:name => '5000m', :description => '5000m', :competition_id => @comp.id)
Event.create!(:name => '4 x 100m', :description => '4 x 100m', :competition_id => @comp.id)
Event.create!(:name => '4 x 400m', :description => '4 x 400m', :competition_id => @comp.id)
Event.create!(:name => 'High Jump', :description => 'High Jump', :competition_id => @comp.id)
Event.create!(:name => 'Long Jump', :description => 'Long Jump', :competition_id => @comp.id)
Event.create!(:name => 'Triple Jump', :description => 'Triple Jump', :competition_id => @comp.id)
Event.create!(:name => 'Shotput', :description => 'Shotput', :competition_id => @comp.id)
Event.create!(:name => 'Discuss', :description => 'Discuss', :competition_id => @comp.id)
Event.create!(:name => 'Javelin', :description => 'Javelin', :competition_id => @comp.id)

@comp = Competition.create!(:name => 'Swimming Test', :description => 'A Swimming Competition',
  :start_date => '2014-3-1', :end_date => '2014-3-1', :registration_close_date => '2014-3-1',
  :image => open("app/assets/images/sheffield.jpg"), :location => 'Ponds Forge, Sheffield, England',
  :user_id => @user.id)

Event.create!(:name => '50m Freestyle', :description => '50m Freestyle', :competition_id => @comp.id)
Event.create!(:name => '100m Freestyle', :description => '100m Freestyle', :competition_id => @comp.id)
Event.create!(:name => '200m Freestyle', :description => '200m Freestyle', :competition_id => @comp.id)
Event.create!(:name => '400m Freestyle', :description => '400m Freestyle', :competition_id => @comp.id)
Event.create!(:name => '50m Backstroke', :description => '50m Backstroke', :competition_id => @comp.id)
Event.create!(:name => '100m Backstroke', :description => '100m Backstroke', :competition_id => @comp.id)
Event.create!(:name => '50m Breaststroke', :description => '50m Breaststroke', :competition_id => @comp.id)
Event.create!(:name => '100m Breaststroke', :description => '100m Breaststroke', :competition_id => @comp.id)
Event.create!(:name => '50m Butterfly', :description => '50m Butterfly', :competition_id => @comp.id)
Event.create!(:name => '100m Butterfly', :description => '100m Butterfly', :competition_id => @comp.id)
Event.create!(:name => '150m Individual Medley', :description => '150m Individual Medley', :competition_id => @comp.id)
Event.create!(:name => '200m Individual Medley', :description => '200m Individual Medley', :competition_id => @comp.id)
Event.create!(:name => '4 x 50m Freestyle Relay', :description => '4 x 50m Freestyle Relay', :competition_id => @comp.id)
Event.create!(:name => '4 x 100m Freestyle Relay', :description => '4 x 100m Freestyle Relay', :competition_id => @comp.id)
Event.create!(:name => '4 x 50m Medley Relay', :description => '4 x 50m Medley Relay', :competition_id => @comp.id)
Event.create!(:name => '4 x 100m Medley Relay', :description => '4 x 100m Medley Relay', :competition_id => @comp.id)
