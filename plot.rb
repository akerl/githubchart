#!/usr/bin/env ruby

require 'github_stats'
require 'matrix'
require 'rasem'

Colors = ['#eeeeee', '#d6e685', '#8cc665', '#44a340', '#1e6823']

data = Github_Stats.new(ARGV.first).data

data.first.date.wday.times { data.unshift Github_Stats::Datapoint.new(data.first.date.prev_day, -1) }
(6 - data.last.date.wday).times { data << Github_Stats::Datapoint.new(data.last.date.next, -1) }

Grid = Matrix[*data.each_slice(7).to_a.transpose]

img = Rasem::SVGImage.new(10 * Grid.row_count, 10 * Grid.column_count) do
    # stuff
end

