namespace :app do
  desc "Fill app"
  task migrate_images: :environment do
    tasks = %w[db:drop db:create db:migrate db:seed]
    tasks.each { |t| Rake::Task[t].invoke }

    Dir.chdir("#{Rails.root}/lib/assets/to_table/")
    categories = Dir['*'].select { |f| File.directory? f }

    categories.each do |it|
      puts "create category #{it}" if Category.create!(name: it, user_id: 1)
      upload_images(it)
    end
  end

  def upload_images(category_name)
    Dir.chdir("#{Rails.root.to_s}/lib/assets/to_table/#{category_name}")
    image_paths = Dir['*.*']
    category = Category.where(name: category_name)

    i = 1
    image_paths.each do |img_path|
      file_img = File.open(img_path)
      Image.create!(picture: file_img, image_name: ('d_img_' + i.to_s), user_id: 1,
                    category_id: category[0].id)
      puts "\tUpload #{File.basename(img_path)}"

      file_img.close
      i += 1
    end
  end
end
