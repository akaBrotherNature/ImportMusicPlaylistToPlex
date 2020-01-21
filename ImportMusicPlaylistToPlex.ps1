######### Variables ##########

$PlexUsername = "" # Put your Plex username between the quotation marks.

$PlexPassword = "" # Put your Plex password between the quotation marks.

$PlexServerLocation = "127.0.0.1" # Put your Plex server location (URL or IP address) between the quotation marks, the default "127.0.0.1" will work for local installations.




######### Get Plex authentication token ##########

$PlexGetTokenUrl = "https://plex.tv/users/sign_in.xml"

$Headers = @{ }

$Headers.Add("X-Plex-Client-Identifier", "Playlist Importer") | Out-Null

$Headers.Add("X-Plex-Product", "Playlist Importer") | Out-Null

$Headers.Add("X-Plex-Version", "v1") | Out-Null

$Body = "user[login]=$PlexUsername&user[password]=$PlexPassword"

$PlexServerResponse = Invoke-RestMethod -Headers: $Headers -Body $Body -Method Post -Uri: $PlexGetTokenUrl

$PlexToken = $PlexServerResponse.User.AuthenticationToken




########## Get section ID for music library ##########

$PlexServerResponse = Invoke-RestMethod -Uri "http://$($PlexServerLocation):32400/library/sections?X-Plex-Token=$PlexToken"

$PlexLibraries = $PlexServerResponse.MediaContainer.Directory

$SelectedLibraryName = $PlexLibraries | Select-Object -Property "title", "key" | Sort-Object | Out-GridView -OutputMode Single -Title "Select Plex library"

$SelectedLibraryKey = $SelectedLibraryName.key




########## Get playlist files ##########

Add-Type -AssemblyName System.Windows.Forms

$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ 

    InitialDirectory = [Environment]::GetFolderPath('Desktop') 

    Filter           = 'Playlist Files (*.m3u)|*.m3u'

    Multiselect      = $True

}

$null = $FileBrowser.ShowDialog()

$PlaylistFilePaths = $FileBrowser.FileNames




########## Import playlist files into Plex ##########

foreach ($Playlist in $PlaylistFilePaths) {

    Invoke-WebRequest -Uri "http://$($PlexServerLocation):32400/playlists/upload?sectionID=$SelectedLibraryKey&path=$Playlist&X-Plex-Token=$PlexToken" -Method Post | Out-Null
    '"' + $Playlist.split('\')[-1] + '"' + " imported to Plex`n"

}

Read-Host -Prompt "Playlists imported, press any key to exit"
