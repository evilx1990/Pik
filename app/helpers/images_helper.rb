module ImagesHelper
  def previous_image(image_rel)
    image = Image.preview(image_rel.category, image_rel.created_at)
    result(image, 'app_images/prev.png')
  end

  def next_image(image_rel)
    image = Image.next(image_rel.category, image_rel.created_at)
    result(image, 'app_images/next.png')
  end

  private

  def result(image, source)
    a = image.nil? ? ['#', 'opacity: 0.2;'] : [category_image_path(category_id: image.category.slug, id: image.slug), 'opacity: 1']
    link_to(a[0], class: 'col-1 m-auto') do
      image_tag(source, alt: '', class: 'w-100 h-100', style: "#{a[1]}")
    end
  end
end
