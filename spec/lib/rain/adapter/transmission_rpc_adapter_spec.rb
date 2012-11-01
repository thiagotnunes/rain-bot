  require 'spec_helper'

describe Rain::Adapter::TransmissionRpcAdapter do
  subject { Rain::Adapter::TransmissionRpcAdapter.new }

  it 'lists all the torrents' do
    Transmission.stub(:torrents).and_return(torrent_list)

    subject.list.should == [{
      id: 1,
      name: "first",
      percent_done: 10,
      total_size: 100,
      download_speed: 1000
    },
    {
      id: 2,
      name: "second",
      percent_done: 20,
      total_size: 200,
      download_speed: 2000
    },
    {
      id: 3,
      name: "third",
      percent_done: 30,
      total_size: 300,
      download_speed: 3000
    }]
  end

  context "adding a torrent" do
    it 'adds a torrent' do
      Transmission::RPC::Torrent.should_receive(:+).with("url").and_return(3)

      subject.add("url")
    end

    it 'throws an exception when could not add the torrent' do
      Transmission::RPC::Torrent.should_receive(:+).with("url").and_return(nil)

      expect { subject.add("url") }.to raise_error(Rain::TorrentOperationError)
    end
  end

  it 'removes a torrent' do
    perform_on(3, :remove, :delete!)
  end

  it 'starts a torrent' do
    perform_on(3, :start, :start!)
  end

  it 'stops a torrent' do
    perform_on(3, :stop, :stop!)
  end

  private

  def perform_on(id, method, adapter_method)
    torrents = torrent_list
    Transmission.stub(:torrents).and_return(torrents)
    torrents.find { |t| t.id == id }.should_receive(adapter_method)

    subject.send(method, id)
  end

  def torrent_list
      [Transmission::RPC::Torrent.new({
        "id" => 1,
        "name" => "first",
        "percentDone" => 10,
        "totalSize" => 100,
        "rateDownload" => 1000,
        "addedDate" => Date.new,
        "comment" => "no comments",
        "eta" => 10,
        "leftUntilDone" => 30,
        "torrentFile" => "torrent",
        "hashString" => "4328092fhdskhfsk",
        "status" => 4
      }),
      Transmission::RPC::Torrent.new({
        "id" => 2,
        "name" => "second",
        "percentDone" => 20,
        "totalSize" => 200,
        "rateDownload" => 2000,
        "addedDate" => Date.new,
        "comment" => "no comments",
        "eta" => 10,
        "leftUntilDone" => 30,
        "torrentFile" => "torrent",
        "hashString" => "4328092fhdskhfsk",
        "status" => 4
      }),
      Transmission::RPC::Torrent.new({
        "id" => 3,
        "name" => "third",
        "percentDone" => 30,
        "totalSize" => 300,
        "rateDownload" => 3000,
        "addedDate" => Date.new,
        "comment" => "no comments",
        "eta" => 10,
        "leftUntilDone" => 30,
        "torrentFile" => "torrent",
        "hashString" => "4328092fhdskhfsk",
        "status" => 4
      })
    ]
  end
end
