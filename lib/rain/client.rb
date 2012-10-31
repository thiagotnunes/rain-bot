module Rain
  class Client
    def initialize(transmission)
      @transmission = transmission
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

    def add(url)
      torrent_operation("#{url} was successfully added.") do
        @transmission.add(url)
      end
    end

    def remove(id)
      torrent_operation("Torrent with id #{id} was successfully removed.") do
        @transmission.remove(id)
      end
    end

    def start(id)
      torrent_operation("Torrent with id #{id} has been started.") do
        @transmission.start(id)
      end
    end

    private

    def description_for(t)
      description = "#{t[:id]} - #{t[:name]}, #{t[:percent_done]}% done of #{t[:total_size]} bytes."
      description += " Downloading at #{t[:download_speed]} bytes per second." unless t[:percent_done] == 100
      description
    end

    def torrent_operation(success_message)
      yield
      success_message
    rescue Exception => e
      "An error has occurred when performing the operation: #{e}."
    end
  end
end
