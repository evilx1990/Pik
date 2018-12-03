# frozen_string_literal: true

require 'rails_helper'

describe 'categories/show.html.haml', type: :view do
  let(:category_images) { create(:category_with_images) }

  before do
    sign_in(create(:user))
  end

end