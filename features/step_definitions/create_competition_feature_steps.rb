When(/^I select file "(.*?)" for "(.*?)"$/) do |file, field|
  attach_file field, file
end

When(/^I fill in field "(.*?)" with date "(.*?)"$/) do |field, date|
  fill_in field, :with => eval(date + ".strftime('%d/%m/%Y')")
end