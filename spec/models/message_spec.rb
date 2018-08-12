require 'spec_helper'

RSpec.describe Message, type: :model do
  let(:client) { Client.new(first_name: 'Kitty', phone_number: '555-222-3333') }
  let(:message) { Message.new(text: 'test',
                              client: client,
                              outbound: true,
                              created_at: '2018-08-11 04:56:15 UTC') }

  describe '#sender' do
    subject(:sender) { message.sender }

    context 'when the message is outbound' do
      before { message.update_attribute(:outbound, true) }

      it { is_expected.to eq 'App' }
    end

    context 'when the message is not outbound' do
      before { message.update_attribute(:outbound, false) }

      it { is_expected.to eq client.first_name }
    end
  end

  describe '#styled_time' do
    subject(:styled_time) { message.styled_time }

    context 'when it is daylight savings time' do
      include_context 'when it is daylight savings time'

      it { is_expected.to eq "12:56 am" }
    end

    context 'when it is not daylight savings time' do
      include_context 'when it is not daylight savings time'

      it { is_expected.to eq "11:56 pm" }
    end
  end

  describe '#styled_date' do
    subject(:styled_date) { message.styled_date }

    context 'when it is daylight savings time' do
      include_context 'when it is daylight savings time'

      it { is_expected.to eq "August 11, 2018" }
    end

    context 'when it is not daylight savings time' do
      include_context 'when it is not daylight savings time'

      it { is_expected.to eq "August 10, 2018" }
    end
  end
end
