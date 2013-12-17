When(/^I select file "(.*?)" for "(.*?)"$/) do |file, field|
  attach_file field, file
end

