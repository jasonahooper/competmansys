Given(/^there is a competition "(.*?)" with event "(.*?)"$/) do |competition, event|
  @comp = Competition.make!(:name => competition)
  @event = Event.make!(:name => event, :competition_id => @comp.id)
end

Given(/^I am on the events page for competition "(.*?)"$/) do |arg1|
  visit competition_events_path(@comp.id)
end
