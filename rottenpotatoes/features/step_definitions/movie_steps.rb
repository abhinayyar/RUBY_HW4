# Add a declarative step here for populating the DB with movies.

def get_value(column_name)
	#approach to select nodes from Xml document, XPath
  position = "count(//thead/tr/th[text() = '#{column_name}']/preceding-sibling::th) + 1"
  all(:xpath, "//tbody/tr/td[#{position}]").map(&:text)
end

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
	Movie.create(:title => movie['title'], :rating => movie['rating'], :release_date => movie['release_date'])
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
	titles = get_value 'Title'

  expect(titles.index(e1)).to be < titles.index(e2)
end

Then(/^I should see all of the movies$/) do

expect(get_value('Title').size).to eq(Movie.all.count)
end


# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"


When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
	rating_list.split(',').each do |rating|
    if uncheck
      uncheck "ratings_#{rating}"
    else
      check "ratings_#{rating}"
    end
   end
end

#director check added in web.rb
