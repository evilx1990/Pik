module HomeHelper
  def get_slider_img
    Dir.chdir("#{Rails.root}/app/assets/images/slider/")
    Dir.glob("*.{jpg, jpeg, png}")
  end
end
