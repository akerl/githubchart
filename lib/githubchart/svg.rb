require 'svgplot'

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
      chart = SVGPlot.new(width: 13 * grid.column_size + 13,
                          height: 13 * grid.row_size + 13)
      svg_add_points grid, chart
      svg_add_weekdays chart
      svg_add_months chart
      chart.to_s
    end

    private

    # rubocop:disable Style/HashSyntax

    ##
    # Define style for weekday labels

    SVG_WEEKDAY_STYLE = {
      :fill => '#ccc',
      :'text-anchor' => 'middle',
      :'text-align' => 'center',
      :font => '9px Helvetica, arial, freesans, clean, sans-serif',
      :'white-space' => 'nowrap',
      :display => 'display'
    }

    ##
    # Define Style for month labels

    SVG_MONTH_STYLE = {
      :fill => '#aaa',
      :'text-align' => 'center',
      :font => '10px Helvetica, arial, freesans, clean, sans-serif',
      :'white-space' => 'nowrap',
      :display => 'block'
    }

    def svg_point_style(point)
      {
        fill: @colors[@stats.quartile(point.score)],
        :'shape-rendering' => 'crispedges'
      }
    end

    # rubocop:enable Style/HashSyntax

    def svg_add_points(grid, chart)
      grid.each_with_index do |point, y, x|
        next if point.score == -1
        chart.rectangle(
          (x * 13) + 14, (y * 13) + 14, 11, 11,
          data: { score: point.score, date: point.date },
          style: svg_point_style(point)
        )
      end
    end

    def svg_add_weekday(chart, point)
      index = point.date.wday
      letter = point.date.strftime('%a')[0]
      style = SVG_WEEKDAY_STYLE.clone
      style[:display] = 'none' unless [1, 3, 5].include? index
      chart.text(4, 13 * index + 23, style: style) { raw letter }
    end

    def svg_add_weekdays(chart)
      @stats.raw.first(7).each { |point| svg_add_weekday chart, point }
    end

    def svg_get_month_offsets # rubocop:disable Metrics/AbcSize
      list = @stats.raw.select { |x| x.date.sunday? }
      list.unshift(@stats.raw.first) unless @stats.raw.first.date.sunday?
      list.map! { |x| x.date.strftime('%b') }
      acc = 0
      list.chunk { |x| x }.map do |month, offset|
        acc += offset.size
        [month, acc - offset.size]
      end
    end

    def svg_add_months(chart)
      offsets = svg_get_month_offsets
      offsets.shift if offsets.take(2).map(&:last) == [0, 1]
      offsets.each do |month, offset|
        next if offset > 50
        chart.text(13 * offset + 14, 9, style: SVG_MONTH_STYLE) { raw month }
      end
    end
  end
end
