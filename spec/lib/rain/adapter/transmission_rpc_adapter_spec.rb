require 'spec_helper'

describe Rain::Adapter::TransmissionRpcAdapter do
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
    adapter = Rain::Adapter::TransmissionRpcAdapter.new

    adapter.list.should == [{
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
end
