shared_context 'when it is daylight savings time' do
  before do
    allow(Time).to receive_message_chain(:now, :dst?).and_return true
  end
end

shared_context 'when it is not daylight savings time' do
  before do
    allow(Time).to receive_message_chain(:now, :dst?).and_return false
  end
end