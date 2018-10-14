require 'spec_helper'

RSpec.describe Client, type: :model do
  subject(:client) { Client.new(first_name: 'Kitty', phone_number: '5556667777') }

  describe 'when the phone number is valid' do
    it { is_expected.to be_valid }
  end

  describe 'when the phone number is not valid' do
    before { client.phone_number = '55566677777' }

    it { is_expected.to_not be_valid }
  end

  describe '#formatted_phone' do
    it 'looks pretty' do
      expect(client.formatted_phone).to eq '(555) 666-7777'
    end
  end

  describe '#unread_messages?' do
    context 'when there are unread messages' do
      before do
        client.save
        Message.create(text: 'test', client_id: client.id)
      end

      it 'returns true' do
        expect(client.unread_messages?).to be_truthy
      end
    end

    context 'when there are no unread messages' do
      it 'returns false' do
        expect(client.unread_messages?).to be_falsy
      end
    end
  end
end