# MPD Tool
[![CodeClimate](http://img.shields.io/codeclimate/github/slnz/mpd_tool.svg?style=flat)](https://codeclimate.com/github/slnz/mpd_tool) [![Coverage](http://img.shields.io/codeclimate/coverage/github/slnz/mpd_tool.svg?style=flat)](https://codeclimate.com/github/slnz/mpd_tool) [![Travis-CI](http://img.shields.io/travis/slnz/mpd_tool.svg?style=flat)](https://travis-ci.org/slnz/mpd_tool) [![Travis-CI](http://img.shields.io/gemnasium/slnz/mpd_tool.svg?style=flat)](https://gemnasium.com/slnz/mpd_tool)
[![Inline docs](http://inch-ci.org/github/slnz/mpd_tool.svg?branch=master&style=flat)](http://inch-ci.org/github/slnz/mpd_tool)

MPD Tool is an online tool that makes it easier than ever to manage your student's support raising process.

We're an open source project and always looking for more developers to help us expand MPD Tool's features. Contact admin@studentlife.org.nz to get involved.

http://mpd.studentlife.org.nz

## Getting Started

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % ./bin/setup

It assumes you have a machine equipped with Ruby, Postgres, etc. If not, set up
your machine with [this script].

[this script]: https://github.com/thoughtbot/laptop

After setting up, you can run the application using [foreman]:

    % foreman start

If you don't have `foreman`, see [Foreman's install instructions][foreman]. It
is [purposefully excluded from the project's `Gemfile`][exclude].

[foreman]: https://github.com/ddollar/foreman
[exclude]: https://github.com/ddollar/foreman/pull/437#issuecomment-41110407

## Guidelines

Use the following guides for getting things done, programming well, and
programming in style.

* [Protocol](http://github.com/thoughtbot/guides/blob/master/protocol)
* [Best Practices](http://github.com/thoughtbot/guides/blob/master/best-practices)
* [Style](http://github.com/thoughtbot/guides/blob/master/style)

## License

MPD Tool is released under the [MIT license](http://www.opensource.org/licenses/MIT)