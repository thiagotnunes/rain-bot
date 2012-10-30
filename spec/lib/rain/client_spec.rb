require 'spec_helper'

class TransmissionAdapter
end

describe Rain::Client do
  let(:transmissionAdapter) { TransmissionAdapter.new }
  subject { Rain::Client.new(transmissionAdapter) }

  context 'adding a new torrent' do
    it 'adds successfully' do
      transmissionAdapter.stub(:add).with("url").and_return(true)

      subject.add("url").should eq("url was successfully added.")
    end

    it 'adds unsuccessfully' do
      error = IndexError.new
      transmissionAdapter.stub(:add).with("url").and_raise(error)

      subject.add("url").should eq("An error has occurred when adding the torrent: #{error}.")
    end
  end
end
