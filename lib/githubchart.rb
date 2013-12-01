require 'githubstats'
require 'matrix'
require 'githubchart/svg'

##
# Graphing tool for creating Github-style contribution charts

module GithubChart
  class << self
    ##
    # Helper to create new charts

    def new(*args)
      self::Chart.new(*args)
    end

    ##
    # Helper to list supported types

    def supported
      @supported ||= []
    end

    ##
    # Helper to check for type support

    def supports?(type)
      supported.include? type.to_sym
    end

    protected

    ##
    # Add support for a type

    def add_support(type)
      @supported ||= []
      @supported << type.to_sym
      p @supported
    end
  end

  ##
  # Default colors for gradient

  COLORS = ['#eeeeee', '#d6e685', '#8cc665', '#44a340', '#1e6823']

  ##
  # Object for parsing and outputing Github stats data

  class Chart
    attr_reader :stats
    attr_accessor :colors

    ##
    # Create a new chart object
    # Passes the username through to GithubStats
    # Uses colors rather than default, if provided

    def initialize(params = {})
      params = { username: params } if params.is_a? String
      @stats = GithubStats.new(params['username'])
      @colors = params['colors'] || GithubChart::Colors
    end

    private

    ##
    # Convert the data into a matrix of weeks
    # The fill value is used to pad the front and backdd

    def matrix(fill_value = -1)
      Matrix[*@stats.pad(fill_value).each_slice(7).to_a.transpose]
    end
  end
end

##
# Add helper methods to Integer

class ::Integer
  ##
  # Add ordinalize to simplify converting to spoken string

  def ordinalize
    return self if self == 0
    return "#{self}th" if (11..13).include?(abs % 100)
    case abs % 10
    when 1 then "#{self}st"
    when 2 then "#{self}nd"
    when 3 then "#{self}rd"
    else "#{self}th"
    end
  end
end
