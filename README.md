# ImportMusicPlaylistToPlex

This powershell script will import m3u playlists to Plex.

## Instructions

Open the file "ImportMusicPlaylistToPlex.ps1" in a text editor. At the top of the file is a section called "variables".

You will need to set the following variables: $PlexUsername, $PlexPassword to your Plex username and password.

The variable $PlexServerLocation is set to 127.0.0.1 by default. This shold work for all local installations of Plex, but can be changed to any IP address or URL

*Example configuration:*

```powershell
######### Variables ##########

$PlexUsername = "example@example.com" # Put your Plex username between the quotation marks.

$PlexPassword = "tHisIsmyPassWord" # Put your Plex password between the quotation marks.

$PlexServerLocation = "127.0.0.1" # Put your Plex server location (URL or IP address) between the quotation marks, the default "127.0.0.1" will work for local installations.
```

## Format of the .m3u file

The m3u playlist file should be a file that ends in the extension ".m3u" and contain the full paths of the music files you want to import, with one path per line.

The name of the file will become the name of the playlist in Plex. Using the same name as an existing playlist will cause the content of that playlist to be overwritten.

For example, a file with the name "Into The Wild.m3u" and the content

*C:\Music\Eddie Vedder\Music For The Motion Picture Into The Wild\1.02. No Ceiling.mp3*

*C:\Music\Eddie Vedder\Music For The Motion Picture Into The Wild\1.05. Long Nights.mp3*

*C:\Music\Eddie Vedder\Music For The Motion Picture Into The Wild\1.13. Photographs.mp3*

will create a Plex playlist called "Into the Wild" which contains the songs "No Ceiling", "Long Nights", and "Photographs".
