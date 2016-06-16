require "csv"
namespace :import_users_csv do
  desc "Import Users from csv file"
  task import_users: [:environment] do
    file = "db/users.csv"
    CSV.foreach(file, headers: true) do |row|
      User.create fullname: row[0], email: row[1], password: row[2],
        password_confirmation: row[3], is_admin: row[4]
    end
  end
end
