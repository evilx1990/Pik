# frozen_string_literal: true

require 'rails_helper'

describe Feedback, type: :model do
  describe 'validation' do
    subject! { create(:feedback) }

    context 'should be invalid' do
      it 'without author email' do
        expect(build(:feedback,
                     email_author: nil,
                     name: subject.name,
                     feedback: subject.feedback)).not_to be_valid
      end

      it 'without author name' do
        expect(build(:feedback,
                     email_author: subject.email_author,
                     name: nil,
                     feedback: subject.feedback)).not_to be_valid
      end

      it 'without author email' do
        expect(build(:feedback,
                     email_author: subject.email_author,
                     name: subject.name,
                     feedback: nil)).not_to be_valid
      end
    end

    context 'successful validation' do
      it 'must be save to data base' do
        expect(Feedback.count).to eq 1
      end
    end


  end
end
