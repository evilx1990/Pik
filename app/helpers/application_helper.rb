module ApplicationHelper
  def categories_present?
    Category.count.zero?
  end

  def get_top_categories(quantity)
    Category.order(count: :desc).limit(quantity)
  end
end
