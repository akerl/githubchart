require 'spec_helper'
require 'tempfile'

describe GithubChart::Chart do
  let(:svg) { GithubChart.new.svg }

  before(:all) do
    @file = Tempfile.new('svg')
    @file.write(GithubChart.new.svg)
    @path = @file.path
    @file.close
  end

  after(:all) { @file.unlink }

  describe '#svg' do
    it 'makes an SVG' do
      expect(`file #{@path}`).to include('Scalable Vector Graphic')
    end
  end
end
