ActiveAdmin.register Image do
  permit_params :path, :user_id, :category_id

  controller do
    def create
      @image = Image.new(permitted_params[:image])

      if @image.save
        Category.find(@image.category_id).increment!(:count)
        redirect_to admin_images_path
      end
    end

    def destroy
      @image = Image.find(params[:id])
      Category.find(@image.category_id).decrement!(:count)
      @image.destroy

      redirect_to admin_image_path
    end
  end
end
