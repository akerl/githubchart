require 'curb'
require 'json'
require 'date'
require 'gruff'

User = 'akerl'
URL = "https://github.com/users/#{User}/contributions_calendar_data"
dates, scores = JSON.parse(Curl::Easy.perform(URL).body_str).transpose

def pad_data(count, index, value, *arrays)
    count.times { arrays.each {|a| a.insert(index, value) } }
end

pad_data(Date.parse(dates.first).wday, 0, nil, dates, scores)
pad_data(8 - Date.parse(dates.last).wday, -1, nil, dates, scores)

p dates
p scores

