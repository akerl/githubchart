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
      chart = Rasem::SVGImage.new(13 * grid.column_size + 13,
                                  13 * grid.row_size + 13)
      svg_add_points grid, chart
      svg_add_weekdays chart
      svg_add_months chart
      chart.close
      chart.output
    end

    private

    # rubocop:disable SymbolName

    ##
    # Define style for weekday labels

    SVG_WEEKDAY_STYLE = {
      :fill => '#ccc',
      :'text-anchor' => 'middle',
      :'text-align' => 'center',
      :font => '9px Helvetica, arial, freesans, clean, sans-serif',
      :'white-space' => 'nowrap',
      :display => 'display',
    }

    ##
    # Define Style for month labels

    SVG_MONTH_STYLE = {
      :fill => '#aaa',
      :'text-align' => 'center',
      :font => '10px Helvetica, arial, freesans, clean, sans-serif',
      :'white-space' => 'nowrap',
      :display => 'block',
    }

    # rubocop:enable SymbolName

    def svg_add_points(grid, chart)
      grid.each_with_index do |point, y, x|
        next if point.score == -1
        chart.rectangle(
          (x * 13) + 14, (y * 13) + 14, 11, 11,
          fill: @colors[@stats.quartile(point.score)]
        )
      end
    end

    def svg_add_weekdays(chart)
      @stats.raw.first(7).each do |point|
        index = point.date.wday
        letter = point.date.strftime('%a')[0]
        style = SVG_WEEKDAY_STYLE.clone
        style[:display] = 'none' unless [1, 3, 5].include? index
        chart.text(4, 13 * index + 23, letter, style)
      end
    end

    def svg_get_month_offsets
      list = @stats.raw.group_by { |x| x.date.strftime('%Y%U').split('-') }
      acc = 0
      list = list.map { |k, v| v.first.date.strftime('%b') }
      list.chunk { |x| x }.map do |month, offset|
        acc += offset.size
        [month, acc - offset.size]
      end
    end

    def svg_add_months(chart)
      svg_get_month_offsets.each do |month, offset|
        next if offset > 52
        chart.text(13 * offset + 14, 9, month, SVG_MONTH_STYLE)
      end
    end
  end
end
