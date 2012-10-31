require 'spec_helper'

describe Rain::Adapter::TransmissionRpcAdapter do
  subject { Rain::Adapter::TransmissionRpcAdapter.new }

  it 'lists all the torrents' do
    Transmission.stub(:torrents).and_return([
      Transmission::RPC::Torrent.new({
        "id" => 10,
        "name" => "first",
        "percentDone" => 20,
        "totalSize" => 1024,
        "rateDownload" => 30,
        "addedDate" => Date.new,
        "comment" => "no comments",
        "eta" => 10,
        "leftUntilDone" => 30,
        "torrentFile" => "torrent",
        "hashString" => "4328092fhdskhfsk",
        "status" => 4
      }),
      Transmission::RPC::Torrent.new({
        "id" => 20,
        "name" => "second",
        "percentDone" => 30,
        "totalSize" => 2048,
        "rateDownload" => 5,
        "addedDate" => Date.new,
        "comment" => "no comments",
        "eta" => 10,
        "leftUntilDone" => 30,
        "torrentFile" => "torrent",
        "hashString" => "4328092fhdskhfsk",
        "status" => 4
      })
    ])

    subject.list.should == [{
      id: 10,
      name: "first",
      percent_done: 20,
      total_size: 1024,
      download_speed: 30
    },
    {
      id: 20,
      name: "second",
      percent_done: 30,
      total_size: 2048,
      download_speed: 5
    }]
  end

  context "adding a torrent" do
    it 'adds a torrent' do
      Transmission::RPC::Torrent.should_receive(:+).with("url").and_return(3)

      subject.add("url")
    end

    it 'throws an exception when could not add the torrent' do
      Transmission::RPC::Torrent.should_receive(:+).with("url").and_return(nil)

      expect { subject.add("url") }.to raise_error(Rain::TorrentOperationException)
    end
  end

  it 'removes a torrent' do
    to_be_removed = Transmission::RPC::Torrent.new({ "id" =>  3 })
    Transmission.stub(:torrents).and_return([
      Transmission::RPC::Torrent.new({ "id" => 1 }),
      Transmission::RPC::Torrent.new({ "id" => 2 }),
      to_be_removed
    ])
    to_be_removed.should_receive(:delete!)

    subject.remove(3)
  end

  it 'starts a torrent' do
    to_be_started = Transmission::RPC::Torrent.new({ "id" =>  3 })
    Transmission.stub(:torrents).and_return([
      Transmission::RPC::Torrent.new({ "id" => 1 }),
      Transmission::RPC::Torrent.new({ "id" => 2 }),
      to_be_started
    ])
    to_be_started.should_receive(:start!)

    subject.start(3)
  end
end
