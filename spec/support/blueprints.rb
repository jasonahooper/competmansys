require 'machinist/active_record'

User.blueprint do
  email         { Faker::Internet.email }
  first_name    { Faker::Name.first_name }
  last_name     { Faker::Name.last_name }
  home_address  { Faker::AddressUK.postcode }
  password      { "password" }
  latitude      { 0 }
  longitude     { 0 }
  object.stubs(:geocode)
end

User.blueprint(:competition_owner) do
  roles         { ["competition_owner"] }
end

Competition.blueprint do
  name        { 'Test' }
  description { 'Test competition' }
  start_date  { 7.days.from_now }
  end_date    { 7.days.from_now + 7.days }
  registration_close_date { 2.days.from_now }
  user_id     { User.make!.id }
  location    { 'somewhere out there' }
  image       { File.open('spec/fixtures/empty.jpg') }
  latitude    { 0 }
  longitude   { 0 }
  object.stubs(:geocode)
end

CompetitionAttendee.blueprint do
  user_id         { User.make!.id }
  competition_id  { Competition.make!.id}
end

Event.blueprint do
  competition_id  { Competition.make!.id }
  name            { 'A Test Event' }
end

EventRegistration.blueprint do
  competition_attendee_id { CompetitionAttendee.make! }
  event_id                { Event.make! }
end