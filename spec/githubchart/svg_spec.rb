require 'spec_helper'
require 'tempfile'

describe GithubChart::Chart do
  before(:all) do
    @file = Tempfile.new('svg')
    @file.write(GithubChart.new(user: 'akerl').render(:svg))
    @path = @file.path
    @file.close
  end

  after(:all) { @file.unlink }

  describe '#render' do
    it 'makes an SVG' do
      expect(`file #{@path}`).to include('Scalable Vector Graphic')
    end

    it 'raises error if render type is unsupported' do
      expect { GithubChart.new(user: 'akerl').render(:dog) }
        .to raise_error(NameError)
    end
  end
end
