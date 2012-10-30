module Rain
  class Client
    def initialize(transmission)
      @transmission = transmission
    end

    def add(url)
      if @transmission.add(url)
        "#{url} was successfully added."
      end
    rescue Exception => e
      "An error has occurred when adding the torrent: #{e}."
    end
  end
end
