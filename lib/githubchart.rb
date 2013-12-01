require 'githubstats'
require 'matrix'

##
# This module creates SVGs based on Github contribution data
# similar to Github's contribution charts

module GithubChart
  class << self
    attr_reader :supported

    ##
    # Add .new() helper for creating a new Chart object

    def new(*args)
      self::Chart.new(*args)
    end

    ##
    # Check for support of outputs

    @supported = []

    begin
      require 'rasem'
      @supported << :svg
    rescue LoadError
      nil
    end

    ##
    # Helper function to check for support

    def supports?(type)
      @supported.include? type.to_sym
    end
  end

  ##
  # Default colors for gradient

  COLORS = ['#eeeeee', '#d6e685', '#8cc665', '#44a340', '#1e6823']

  ##
  # Chart object to format and create the contribution chart

  class Chart
    attr_reader :svg, :stats, :data
    attr_accessor :colors

    ##
    # Create a new chart object
    # Passes the username through to Github_Stats
    # Uses the provided colors for the gradient if provided,
    # otherwise uses the default colors

    def initialize(user = nil, colors = nil)
      @stats = GithubStats.new(user)
      @data = @stats.data
      @colors = colors || GithubChart::COLORS
    end

    ##
    # Convert the data into a padded matrix with 7 rows (Sunday - Saturday)
    # fill_value sets the value used for padding the ends of the matrix

    def matrix(fill_value = nil)
      fill_value ||= -1
      padded_data = @data.clone
      @data.first.date.wday.times do
        x = GithubStats::Datapoint.new(padded_data.first.date - 1, fill_value)
        padded_data.unshift x
      end
      (6 - @data.last.date.wday).times do
        x = GithubStats::Datapoint.new(padded_data.last.date + 1, fill_value)
        padded_data << x
      end
      Matrix[*padded_data.each_slice(7).to_a.transpose]
    end

    ##
    # Generate an SVG of the data

    def svg
      unless GithubChart.supports? :svg
        fail NotImplementedError, 'Install rasem for SVG support'
      end
      grid = matrix
      chart = Rasem::SVGImage.new(13 * grid.column_size, 13 * grid.row_size)
      grid.to_a.each_with_index do |row, y|
        row.each_with_index do |point, x|
          next if point.score == -1
          date = point.date.strftime("%B #{point.date.day.ordinalize} %Y")
          pluralize = point.score != 1 ? 's' : ''
          chart.rectangle(
            (x * 13) + 2, (y * 13) + 2, 11, 11,
            fill: COLORS[@stats.quartile(point.score)],
            title: "#{point.score} contribution#{pluralize} on #{date}"
          )
        end
      end
      chart.close
      chart.output
    end
  end

  ##
  # Add ordinalize to Integer to simplify converting to spoken string

  class ::Integer
    def ordinalize
      if (11..13).include?(abs % 100)
        "#{self}th"
      else
        case abs % 10
        when 1 then "#{self}st"
        when 2 then "#{self}nd"
        when 3 then "#{self}rd"
        else "#{self}th"
        end
      end
    end
  end
end
