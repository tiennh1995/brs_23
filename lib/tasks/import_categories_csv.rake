require "csv"
namespace :import_categories_csv do
  desc "Import Categories from csv file"
  task import_categories: [:environment] do
    file = "db/categories.csv"
    CSV.foreach(file, headers: true) do |row|
      Category.create name: row[0]
    end
  end
end
