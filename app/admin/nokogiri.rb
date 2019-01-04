# frozen_string_literal: true

ActiveAdmin.register_page 'Nokogiri' do
  content do
    render 'nokogiri/form'
  end

  page_action :import, method: :post do
    if params[:nokogiri][:url].match?(/^https?:\/\//)
      Dir.chdir("#{Rails.root}/app/assets/images/")

      root = params[:nokogiri][:url][/^https?:\/\/[^\/]+/]
      protocol = root[/^https?:/]
      names = []

      Nokogiri::HTML(open(params[:nokogiri][:url])).xpath('//img/@src').each do |url|
        url = (url.to_s[/^\/\//] ? protocol + url : root + url) unless url[/^https?:\/\//]
        new_name = SecureRandom.hex(10)
        name = File.basename(url)

        if name[/\.jpg$|\.jpeg$|\.png$/]
          File.open(name, 'wb') { |f| f.write(open(url).read) }
          names << new_name + name[/\.jpg$|\.jpeg$|\.png$/]
          File.rename(name, names[-1])
        end
      rescue
        File.delete(File.basename(url.to_s))
      end

      flash[:error] = 'Images not found' if names.count.eql?(0)

      render 'nokogiri/images', locals: { names: names }
    else
      flash[:error] = 'Bad URL'
      redirect_to admin_nokogiri_path
    end
  end

  page_action :create, method: :post do
    names = params[:nokogiri][:images]
    names.delete('')

    if names.count > 0
      user = User.find(1)
      category = Category.find_or_create_by(name: 'Admin Choice', user: user)

      names.each do |name|
        file = File.open("#{Rails.root}/app/assets/images/#{name}")
        Image.new(picture: file,
                  image_name: name[0, 5],
                  category: category,
                  user: user).save!
        file.close
      end
      flash[:notice] = 'Successful'
    else
      flash[:error] = 'You dont select any image'
    end

    Dir.glob('*.*').each { |filename| File.delete(filename) }
    redirect_to admin_nokogiri_path
  end
end
