require 'rasem'

##
# Add SVG support to GithubChart

module GithubChart
  ##
  # Declare SVG support

  add_support(:svg)

  ##
  # Convert stats into SVG

  class Chart
    def svg
      grid = matrix
      chart = Rasem::SVGImage.new 13 * grid.column_size, 13 * grid.row_size
      grid.each_with_index do |point, row, col|
        next if point.score == -1
        chart.rectangle((x * 13) + 2, (y * 13) + 2, 11, 11,
                        fill: @colors[@stats.quartile(point.score)])
      end
      chart.close
      chart.output
    end
  end
end
