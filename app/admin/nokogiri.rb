ActiveAdmin.register_page 'Nokogiri' do
  content do
    render 'nokogiri/form'
  end

  page_action :import, method: :post do
    if params[:nokogiri][:url].match?(/^(https:\/\/|http:\/\/)/)
      page = Nokogiri::HTML(open(params[:nokogiri][:url]))
      @images = page.search('img')
      render 'nokogiri/images'
    end
  end
end
