module Rain
  class Client
    def initialize(transmission)
      @transmission = transmission
    end

    def add(url)
      @transmission.add(url)
      "#{url} was successfully added."
    rescue Exception => e
      "An error has occurred when adding the torrent: #{e}."
    end

    def list
      torrents = @transmission.list
      if torrents.empty?
        "There are no torrents being downloaded."
      else
        "The following torrents are being downloaded:\n" +
        torrents.map do |t|
          description_for(t)
        end.join("\n")
      end
    end

    private

    def description_for(t)
      description = "#{t[:id]} - #{t[:name]}, #{t[:percent_done]}% done of #{t[:total_size]} bytes."
      description += " Downloading at #{t[:download_speed]} bytes per second." unless t[:percent_done] == 100
      description
    end
  end
end
