# frozen_string_literal: true

require 'rails_helper'

describe 'Routing to feedbacks', type: :routing do
  context 'should not be routes' do
    subject { create(:feedback) }

    it '/feedbacks to feedbacks#index' do
      expect(get: "#{I18n.locale}/feedbacks").not_to be_routable
    end

    it '/feedback to feedbacks#show' do
      expect(get: "#{I18n.locale}/feedbacks/#{subject.id}").not_to be_routable
    end

    it '/feedbacks to feedbacks#edit' do
      expect(get: "#{I18n.locale}/feedbacks/#{subject.id}/edit").not_to be_routable
    end

    it '/feedback to feedbacks#update' do
      expect(put: "#{I18n.locale}/feedbacks/#{subject.id}").not_to be_routable
    end

    it '/feedback to feddbacks#destroy' do
      expect(delete: "#{I18n.locale}/feedbacks/#{subject.id}").not_to be_routable
    end
  end
end