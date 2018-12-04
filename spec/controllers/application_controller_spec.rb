# frozen_string_literal: true

require 'rails_helper'

describe ApplicationController, type: :controller do
  let(:activity) { create(:activity) }

  controller do
    def index; end
  end

  before { sign_in(create(:user)) }

  describe 'methods' do
    context '#record_activity' do
      it 'should be true after record activity' do
        expect(controller.send(:record_activity, 'navigation')).to be_truthy
      end
    end

    context '#set_locale' do
      before do
        get :index, params: { locale: :ru }, format: 'text/html'
      end

      it 'should be set locale from params' do
        expect(I18n.locale).to eq :ru
      end
    end
  end
end