module Rain
  class Client
    def initialize(transmission)
      @transmission = transmission
    end

    def add(url)
      @transmission.add(url)
    end
  end
end
