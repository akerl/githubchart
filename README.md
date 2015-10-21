GithubChart
============

[![Gem Version](https://img.shields.io/gem/v/githubchart.svg)](https://rubygems.org/gems/githubchart)
[![Dependency Status](https://img.shields.io/gemnasium/akerl/githubchart.svg)](https://gemnasium.com/akerl/githubchart)
[![Build Status](https://img.shields.io/circleci/project/akerl/githubchart.svg)](https://circleci.com/gh/akerl/githubchart)
[![Coverage Status](https://img.shields.io/codecov/c/github/akerl/githubchart.svg)](https://codecov.io/github/akerl/githubchart)
[![Code Quality](https://img.shields.io/codacy/e8ee7e2aba4c4a01b93d5c0493bef68b.svg)](https://www.codacy.com/app/akerl/githubchart)
[![MIT Licensed](https://img.shields.io/badge/license-MIT-green.svg)](https://tldrlegal.com/license/mit-license)

Generates an SVG of your Github contributions:

![Example image](http://akerl.github.io/githubchart/chart.svg)

![Other user example](http://akerl.github.io/githubchart/other_user.svg)

## Usage

Run `githubchart path/to/svg` to generate an SVG. To override the default username (pulled from your local shell or .gitconfig), use `githubchart -u username path/to/svg`

GithubChart also allows you to provide input from a file instead of pulling data from Github. You can pass JSON to GithubChart by using `githubchart -i /path/to/file /path/to/svg`, or use '-' to use STDIN. See spec/examples/input.json for example data.

If you don't provide a file path, the resulting SVG will be printed to stdout.

To modify the color scheme used, you can provide `-c SCHEME`. For example, `githubchart -c halloween` uses GitHub's halloween colors. Use `-s` to list the available schemes.

### Hosted SVG

A hosted service for loading these SVGs was made by @2016rshah: http://ghchart.rshah.io/ ([source code](https://github.com/2016rshah/githubchart-api))

## Installation

    gem install githubchart

## License

githubchart is released under the MIT License. See the bundled LICENSE file for details.

