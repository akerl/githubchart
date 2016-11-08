require 'spec_helper'
require 'tempfile'

def test_svg(type)
  file = Tempfile.new('svg')
  file.write(GithubChart.new(user: 'akerl').render(type))
  path = file.path
  file.close
  res = `file #{path}`
  file.unlink
  res
end

describe GithubChart::Chart do
  describe '#render_svg' do
    it 'makes an SVG' do
      expect(test_svg(:svg)).to include('Scalable Vector Graphic')
    end
  end

  describe '#render_svg_square' do
    it 'makes an SVG' do
      expect(test_svg(:svg_square)).to include('Scalable Vector Graphic')
    end
  end
end
