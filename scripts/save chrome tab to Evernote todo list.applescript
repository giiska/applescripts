
set tabUrl to missing value
set theNote to missing value
set tabTitle to missing value
set activeApp to missing value

tell application "Google Chrome"
    --activate
    tell application "System Events"
        set activeApp to name of application processes whose frontmost is true
        --Don't execute when active window is not chrome or Evernote
        if (activeApp as string) is not equal to "Evernote" and (activeApp as string) is not equal to "Google Chrome" then
            error number -128
        end if
        tell application process "Google Chrome"
            set tabUrl to value of text field 1 of toolbar 1 of window 1
            -- Make sure start with http
            if (characters 4 thru 1 of tabUrl as string) is not equal to "http" then
                set tabUrl to "http://" & tabUrl
            end if
            set tabTitle to (title of window 1)
        end tell
    end tell
end tell

--delay 0.2

--log tabTitle
--log tabUrl
--return

tell application "Evernote"
    try
        set myNote to (find notes "0000000 this is a read later")
        set theNote to item 1 of myNote -- return one note
        set notifyTitle to "[note]: " & (get title of theNote)
        set addContent to "<br/>" & tabTitle & "<br/>" & "<a href=\"" & tabUrl & "\">" & tabUrl & "</a>"
        try
            append theNote html addContent
        on error errMsg
            display notification "Error with append method."
            try
                set noteHTML to (HTML content of item 1 of theNote)
                set editHTML to noteHTML & addContent
                set (HTML content of item 1 of theNote) to editHTML
            on error errMsg
                display notification "Failed all."
            end try
        end try
        -- Only notify when Evernote is not mostfront
        if (activeApp as string) is not equal to "Evernote" then
            display notification tabUrl with title notifyTitle subtitle "《" & tabTitle & "》"
        end if
    end try
end tell