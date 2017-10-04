require 'svgplot'

##
# Add SVG support to GithubChart
module GithubChart
  ##
  # Declare SVG support

  add_support(:svg)
  add_support(:svg_square)

  ##
  # Convert stats into SVG
  class Chart
    private

    def render_svg
      grid = matrix
      chart = SVGPlot.new(width: 12 * grid.column_size + 27,
                          height: 12 * grid.row_size + 20)
      svg_add_points grid, chart
      svg_add_weekdays chart
      svg_add_months chart
      chart.to_s
    end

    def render_svg_square
      grid = matrix.minor(0, 7, -7, 7)
      chart = SVGPlot.new(width: 12 * grid.column_size - 2,
                          height: 12 * grid.row_size - 2)
      svg_add_points grid, chart, 0, 0
      chart.to_s
    end

    # rubocop:disable Style/HashSyntax, Lint/UnneededDisable

    ##
    # Define style for weekday labels

    SVG_WEEKDAY_STYLE = {
      :fill => '#767676',
      :'text-anchor' => 'start',
      :'text-align' => 'center',
      :'font-family' => '-apple-system, BlinkMacSystemFont, \'Segoe UI\', Helvetica, Arial, sans-serif, \'Apple Color Emoji\', \'Segoe UI Emoji\', \'Segoe UI Symbol\'', # rubocop:disable Metrics/LineLength
      :'font-size' => '9px',
      :'white-space' => 'nowrap'
    }.freeze

    ##
    # Define Style for month labels

    SVG_MONTH_STYLE = {
      :fill => '#767676',
      :'text-align' => 'center',
      :'font-family' => '-apple-system, BlinkMacSystemFont, \'Segoe UI\', Helvetica, Arial, sans-serif, \'Apple Color Emoji\', \'Segoe UI Emoji\', \'Segoe UI Symbol\'', # rubocop:disable Metrics/LineLength
      :'font-size' => '10px',
      :'white-space' => 'nowrap',
      :display => 'block'
    }.freeze

    def svg_point_style(point)
      {
        fill: @colors[@stats.quartile(point.score)],
        :'shape-rendering' => 'crispedges'
      }
    end

    # rubocop:enable Style/HashSyntax, Lint/UnneededDisable

    def svg_add_points(grid, chart, xpadding = 27, ypadding = 20)
      grid.each_with_index do |point, y, x|
        next if point.score == -1
        chart.rectangle(
          (x * 12) + xpadding, (y * 12) + ypadding, 10, 10,
          data: { score: point.score, date: point.date },
          style: svg_point_style(point)
        )
      end
    end

    def svg_add_weekday(chart, point)
      index = point.date.wday
      letter = point.date.strftime('%a')
      style = SVG_WEEKDAY_STYLE.dup
      style[:display] = 'none' unless [1, 3, 5].include? index
      shift = index > 3 ? 29 : 28
      chart.text(0, 12 * index + shift, style: style) { raw letter }
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
      offsets.shift if [1, 2].include? offsets[1].last
      offsets.each do |month, offset|
        next if offset > 50
        chart.text(12 * offset + 27, 10, style: SVG_MONTH_STYLE) { raw month }
      end
    end
  end
end
