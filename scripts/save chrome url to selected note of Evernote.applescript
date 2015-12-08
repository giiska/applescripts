
set tabUrl to missing value
set theNote to missing value
set tabTitle to missing value
set activeApp to missing value

tell application "Google Chrome"
    --activate
    tell application "System Events"
        set activeApp to name of application processes whose frontmost is true
        tell application process "Google Chrome"
            set tabUrl to value of text field 1 of toolbar 1 of window 1
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
        set theNotes to selection
        set theNote to first item in theNotes
        set notifyTitle to "[note]: " & (get title of theNote)
        set addContent to "<br/>" & tabTitle & "<br/>" & "<a href=\"" & tabUrl & "\">" & tabUrl & "</a>"
        try
            append theNote html addContent
        on error errMsg
            display notification "got the error 'Evernote got an error: Operation would exceed monthly upload allowance. '"
            try
                set noteHTML to (HTML content of item 1 of theNote)
                set editHTML to noteHTML & addContent
                set (HTML content of item 1 of theNote) to editHTML
            on error errMsg
                display notification "Ok, we failed."
            end try
        end try
        -- Only notify when Evernote is not mostfront
        if (activeApp as string) is not equal to "Evernote" then
            display notification tabUrl with title notifyTitle subtitle "《" & tabTitle & "》"
        end if
    end try
end tell