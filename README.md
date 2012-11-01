Irc bot that manages your torrents through Transmission interface.

This is done for usage on the Mac OS X.

# Configuration

Copy the configuration_example YAML file and rename it to configuration.yml

On the configuration.yml, fill out the server that you want to login, the bot nickname, the password registered for it and the channel you want him to log in to.

# How to use

Make sure that you have Transmission running with remote access enabled (it's web interface), since the bot will communicate with Tranmission by sending HTTP requests to localhost:9091 (default Transmission server). 

Run the bundle command and the application.rb as follows:

$ bundle
$ ruby -rubygems application.rb

Once the bot has logged in into the server you can issue the following commands:

$ !list

Will list out the current torrents being downloaded, and provide the id for all of these.

$ !add <torrent url>

Adds a new torrent to transmission using the provided torrent url.

$ !remove <torrent id>

Removes the torrent with the given id.

$ !start <torrent id>

Starts the torrent with the given id.

$ !stop <torrent id>

Stops the torrent with the given id.
