# frozen_string_literal: true

namespace :app do
  desc "Fill app"
  task migrate_images: :environment do
    tasks = %w(db:migrate db:seed)
    tasks.each { |t| Rake::Task[t].invoke }

    Dir.chdir("#{Rails.root}/lib/assets/to_table/images")
    categories = Dir['*'].select { |f| File.directory? f }

    categories.each do |name|
      Category.create!(name: name, user: User.first, preview: get_preview(name))
      puts "create category #{name}"
      upload_images(name)
    end
  end

  def upload_images(category_name)
    Dir.chdir("#{Rails.root.to_s}/lib/assets/to_table/images/#{category_name}")
    images = Dir['*.*']
    category = Category.find_by(name: category_name)

    images.each_with_index do |img, i|
      File.open(img) do |file|
        Image.create!(picture: file, name: img[%r(^[^\\.]+)], user: User.first, category: category)
        puts "\tUpload #{File.basename(img)}"
      end
    end
  end

  def get_preview(category_name)
    Dir.chdir("#{Rails.root.to_s}/lib/assets/to_table/preview")
    image = Dir[category_name + '.*']
    File.open(image[0], 'rb')
  end
end
