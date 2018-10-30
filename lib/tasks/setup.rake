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
    category = Category.find_by(name: category_name)

    image_paths.each_with_index do |img_path, i|
      file_img = File.open(img_path)
      puts "\tUpload #{File.basename(img_path)}" if Image.create!(picture: file_img, image_name: ('d_img_' + (i + 1).to_s),
                                                                  user_id: 1, category_id: category.id)
      file_img.close
    end
  end
end
