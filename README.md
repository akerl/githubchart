GithubChart
============

[![Gem Version](https://badge.fury.io/rb/githubchart.png)](http://badge.fury.io/rb/githubchart)
[![Dependency Status](https://gemnasium.com/akerl/githubchart.png)](https://gemnasium.com/akerl/githubchart)
[![Code Climate](https://codeclimate.com/github/akerl/githubchart.png)](https://codeclimate.com/github/akerl/githubchart)
[![Coverage Status](https://coveralls.io/repos/akerl/githubchart/badge.png?branch=master)](https://coveralls.io/r/akerl/githubchart?branch=master)
[![Build Status](https://travis-ci.org/akerl/githubchart.png?branch=master)](https://travis-ci.org/akerl/githubchart)

Generates an SVG of your Github contributions:

![Example image](http://akerl.github.io/githubchart/chart.svg)

![Other user example](http://akerl.github.io/githubchart/other_user.svg)

## Usage

Run `githubchart path/to/svg` to generate an SVG. To override the default username (pulled from your local shell or .gitconfig), use `github_chart -u username path/to/svg`

## Installation

    gem install githubchart

## License

GithubChart is released under the MIT License. See the bundled LICENSE file for details.

