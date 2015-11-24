set noteId to "evernote:///view/2147483647/s224/1bf8540c-4a5b-4883-b1b9-01261e91033a/1bf8540c-4a5b-4883-b1b9-01261e91033a/"
set myNote to {}
set tabUrl to missing value
set theNote to missing value
set tabTitle to missing value

tell application "Google Chrome"
    --activate
    tell application "System Events"
        tell application process "Google Chrome"
            set tabUrl to value of text field 1 of toolbar 1 of window 1
            set tabTitle to (title of window 1)
        end tell
    end tell
end tell

delay 0.2

--debug
--return display dialog tabTitle

tell application "Evernote"
    set theNote to find note noteId
    --get title of theNote

    tell theNote to append html "<br/><br/>" & tabTitle & "<br/>" & tabUrl 
    --tell theNote to append text "23"
end tell

display notification tabUrl with title "Sent Chrome tab url to Evernote" subtitle "《" & tabTitle & "》"