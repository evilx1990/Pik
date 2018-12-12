module CategoriesHelper
  def categories_zero?
    Category.count.zero?
  end

  def get_top_categories(quantity)
    Category.all.each do |category|
      other = 0
      category.images.each { |img| other += (img.votes_count + img.comments_count) }
      category.range_count = category.images_count + category.follows_count + other
      category.save!
    end

    Category.order(range_count: :desc).limit(quantity)
  end
end
