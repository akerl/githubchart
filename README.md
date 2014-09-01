GithubChart
============

[![Gem Version](https://img.shields.io/gem/v/githubchart.svg)](https://rubygems.org/gems/githubchart)
[![Dependency Status](https://img.shields.io/gemnasium/akerl/githubchart.svg)](https://gemnasium.com/akerl/githubchart)
[![Code Climate](https://img.shields.io/codeclimate/github/akerl/githubchart.svg)](https://codeclimate.com/github/akerl/githubchart)
[![Coverage Status](https://img.shields.io/coveralls/akerl/githubchart.svg)](https://coveralls.io/r/akerl/githubchart)
[![Build Status](https://img.shields.io/travis/akerl/githubchart.svg)](https://travis-ci.org/akerl/githubchart)
[![MIT Licensed](https://img.shields.io/badge/license-MIT-green.svg)](https://tldrlegal.com/license/mit-license)

Generates an SVG of your Github contributions:

![Example image](http://akerl.github.io/githubchart/chart.svg)

![Other user example](http://akerl.github.io/githubchart/other_user.svg)

## Usage

Run `githubchart path/to/svg` to generate an SVG. To override the default username (pulled from your local shell or .gitconfig), use `github_chart -u username path/to/svg`

GithubChart also allows you to provide input from a file instead of pulling data from Github. You can pass JSON to GithubChart by using `githubchart -i /path/to/file`, or use '-' to use STDIN. The JSON must be an array of tuples, with the first element as a date, and the second element being the number of contributions from that date. See spec/examples/input.json for example data.

## Installation

    gem install githubchart

## License

GithubChart is released under the MIT License. See the bundled LICENSE file for details.

