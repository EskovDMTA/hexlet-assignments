# frozen_string_literal: true
require 'csv'

namespace :hexlet do
  desc 'Import users from a CSV file'
  task :import_users, [:path] => :environment do |_t, args|
    path = args[:path]
    CSV.foreach(path, headers: true) do |row|
      user = {
        first_name: row[0],
        last_name: row[1],
        birthday: Date.strptime(row[2], '%m/%d/%Y'),
        email: row[3]
      }
      User.create(user)
    end

  end

end
