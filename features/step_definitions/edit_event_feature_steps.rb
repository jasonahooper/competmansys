Given(/^there is an event for "(.*?)" named "(.*?)"$/) do |competition, event|
  @comp = Competition.make!(:name => competition)
  @event = Event.make!(:competition_id => @comp.id, :name => event)
end

Given(/^I am on the events page for "(.*?)"$/) do |competition|
  visit competition_events_path(@comp.id)
end