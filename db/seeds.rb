# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Creating default tags"
%W(差旅費 餐飲費 書報雜誌 影音軟體 雜物 網路服務).each { |name| Tag.create(name: name, is_default: true) }
