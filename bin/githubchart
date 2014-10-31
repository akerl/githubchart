#!/usr/bin/env ruby

require 'githubchart'
require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner =
    "Usage: githubchart (-u username) (-t type) path/for/new/image\n"
  opts.banner << 'Supported types: ' + GithubChart.supported.join(' ')
  opts.on('-uUSER', '--user=USER', 'Specify GitHub user to graph') do |user|
    if options.include? :input
      fail 'The --user and --input flags are incompatible with each other.'
    end
    options[:user] = user
  end
  opts.on('-iFILE', '--input=FILE', 'Specify JSON file, - for stdin') do |input|
    if options.include? :user
      fail 'The --user and --input flags are incompatible with each other.'
    end

    if input.eql? '-'
      fail 'No data provided on stdin' if STDIN.tty?
      contents = STDIN.read
    else
      fail 'File does not exist' unless File.exist? input
      contents = File.read input
    end

    begin
      parsed = JSON.parse(contents)
    rescue => e
      raise "Unable to parse JSON data provided: #{e}"
    end

    options[:data] = GithubStats::Data.new(parsed)
  end
  opts.on('-cSCHEME', '--colors SCHEME', 'Pick a color scheme') do |scheme|
    if GithubChart::COLOR_SCHEMES.include? scheme.to_sym
      options[:colors] = scheme.to_sym
    else
      fail 'Unknown color scheme provided'
    end
  end
  opts.on('-s', '--schemes', 'List known color schemes') do
    puts 'Color schemes:'
    GithubChart::COLOR_SCHEMES.each do |scheme, colors|
      puts "    #{scheme}: #{colors}"
    end
    exit
  end
  opts.on_tail('-v', '--version', 'Show version') do
    puts GithubChart::VERSION
    exit
  end
end.parse!

SVG_Path = ARGV.shift

Chart = GithubChart.new(options).svg

if SVG_Path.nil?
  puts Chart
else
  File.open(SVG_Path, 'w') { |file| file << Chart }
end
