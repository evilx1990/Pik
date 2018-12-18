# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if AdminUser.none? && User.none?
  AdminUser.create!(email: 'admin@gallery.loc',
                    password: 'AdminGallery1',
                    password_confirmation: 'AdminGallery1')
  User.create!(email: 'admin@gallery.loc',
               password: 'AdminGallery1',
               password_confirmation: 'AdminGallery1',
               username: :admin)
end

unless Image.none?
  3.times do
    Image.find(Random.rand(25)).comments.create!(body: 'Its amazing', user_id: 1)
  end
end