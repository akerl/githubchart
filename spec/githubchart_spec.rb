require 'spec_helper'

describe GithubChart do
  describe '.new' do
    it 'creates a new Chart object' do
      expect(GithubChart.new).to be_an_instance_of GithubChart::Chart
    end
  end

  describe '.supported' do
    it 'lists supported types' do
      expect(GithubChart.supported).to include(:svg)
    end
  end

  describe '.supports?' do
    it 'checks for type support' do
      expect(GithubChart.supports? :svg).to be_true
      expect(GithubChart.supports? :fish).to be_false
    end
  end

  describe GithubChart::Chart do
  end
end

describe ::Integer do
  describe '.ordinalize' do
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
