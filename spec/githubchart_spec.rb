require 'spec_helper'

describe GithubChart do
  describe '#new' do
    it 'creates a new Chart object' do
      expect(GithubChart.new).to be_an_instance_of GithubChart::Chart
    end
  end

  describe '#supported' do
    it 'lists supported types' do
      expect(GithubChart.supported).to include(:svg)
    end
  end

  describe '#supports?' do
    it 'checks for type support' do
      expect(GithubChart.supports?(:svg)).to be_truthy
      expect(GithubChart.supports?(:fish)).to be_falsey
    end
  end

  describe GithubChart::Chart do
    it 'has default colors' do
      expect(GithubChart.new.colors.last).to eql '#196127'
    end
    it 'lets you override the colors' do
      expect(GithubChart.new(colors: [1, 2, 3, 4, 5]).colors.last).to eql 5
    end
    it 'lets you pass external data' do
      data = JSON.parse(File.read('spec/examples/input.json'))
      expect(GithubChart.new(data: data).stats).to eql data
    end
    it 'creates a data object when not provided' do
      expect(
        GithubChart.new(username: 'fly').stats
      ).to be_an_instance_of GithubStats::Data
    end
  end

  describe '#render' do
    it 'raises error if render type is unsupported' do
      expect { GithubChart.new(user: 'akerl').render(:dog) }
        .to raise_error(NameError)
    end
  end
end

describe ::Integer do
  describe '#ordinalize' do
    it 'returns a spoken string for a number' do
      [
        [0, '0'],
        [13, '13th'],
        [21, '21st'],
        [32, '32nd'],
        [43, '43rd'],
        [54, '54th']
      ].each do |i, o|
        expect(i.ordinalize).to eql o
      end
    end
  end
end
