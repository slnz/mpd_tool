#!/usr/bin/env ruby

module Heroku
  class Db < Thor
    method_option :keep,   :type => :boolean, :default => false
    method_option :remote, :type => :string,  :default => "mpd-sl-production"
    method_option :host,   :type => :string,  :default => "localhost"
    method_option :user,   :type => :string,  :default => `whoami`
    method_option :dbname, :type => :string
    method_option :dump,   :type => :string,  :default => "latest.dump"

    desc "clone", "clone a remote heroku database to the local environment"
    def clone
      puts "Cloning production database to local environment. This might take a few minutes\n"
      puts "(1/4) capturing production database snapshot..."
      puts `heroku pg:backups capture DATABASE_URL -a #{options[:remote]}`
      puts "(2/4) downloading snapshot..."
      puts `curl -o #{options[:dump]} \`heroku pg:backups public-url -a #{options[:remote]}\``
      puts "(3/4) restoring snapshot..."
      puts `pg_restore --verbose --clean --no-acl --no-owner -h #{options[:host]} -U #{options[:user].gsub("\n", '')} -d #{options[:dbname] || dbname} #{options[:dump]}`
      unless options[:keep]
        puts "(4/4) cleaning up..."
        puts `rm #{options[:dump]}`
      else
        puts "(4/4) skipping cleaning..."
      end
    end

    no_tasks do
      def dbname
        YAML.load_file('config/database.yml')["development"]["database"]
      end
    end
  end
end
