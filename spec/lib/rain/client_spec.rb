require 'spec_helper'

class TransmissionAdapter
end

describe Rain::Client do
  let(:transmissionAdapter) { TransmissionAdapter.new }
  subject { Rain::Client.new(transmissionAdapter) }

  context 'adding a new torrent' do
    it 'adds successfully' do
      transmissionAdapter.should_receive(:add).with("url")

      subject.add("url").should eq("url was successfully added.")
    end

    it 'adds unsuccessfully' do
      error = IndexError.new
      transmissionAdapter.stub(:add).with("url").and_raise(error)

      subject.add("url").should eq("An error has occurred when adding the torrent: #{error}.")
    end
  end

  context 'listing the torrents' do
    it 'lists the existing ones' do
      transmissionAdapter.stub(:list).and_return([{
        id: 3,
        name: "first",
        percent_done: 10,
        total_size: 30,
        download_speed: 20
      }, {
        id: 5,
        name: "second",
        percent_done: 100,
        total_size: 40,
        download_speed: 0
      }])

      subject.list.should eq("The following torrents are being downloaded:\n3 - first, 10% done of 30 bytes. Downloading at 20 bytes per second.\n5 - second, 100% done of 40 bytes.")
    end

    it 'displays a message when no torrents exist' do
      transmissionAdapter.stub(:list).and_return([])

      subject.list.should eq("There are no torrents being downloaded.")
    end
  end

  context 'removing torrents' do
    it 'removes successfully' do
      transmissionAdapter.should_receive(:remove).with(3)

      subject.remove(3).should eq("Torrent with id 3 was successfully removed.")
    end

    it 'removes unsuccessfully' do
      error = IndexError
      transmissionAdapter.stub(:remove).and_raise(error)

      subject.remove(3).should eq("An error has occurred when removing the torrent: #{error}")
    end
  end
end
