require 'spec_helper'

RSpec.describe Message, type: :model do
  let(:message) { Message.new(text: 'test', client_id: 1) }

  describe '#sender' do
    subject(:message_sender) { message.sender }

    context 'when the message is outbound' do
      before { message.update_attribute(:outbound, true) }

      it { is_expected.to eq 'App' }
    end

    context 'when the message is not outbound' do
      before { message.update_attribute(:outbound, true) }

      it { is_expected.to eq 'App' }
    end
  end
end