require 'spec_helper'

class TransmissionAdapter
end

describe Rain::Client do
  let(:transmissionAdapter) { TransmissionAdapter.new }
  subject { Rain::Client.new(transmissionAdapter) }

  context 'adding a new torrent' do
    it 'adds successfully' do
      transmissionAdapter.stub(:add).with("url").and_return(true)

      subject.add("url").should be_true
    end

    it 'adds unsuccessfully' do
      transmissionAdapter.stub(:add).with("url").and_raise(IndexError.new)

      expect {
        subject.add("url")
      }.to raise_error(IndexError)
    end
  end
end
