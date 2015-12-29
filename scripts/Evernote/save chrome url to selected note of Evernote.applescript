(*
Save Chrome Tab to Selected Note of Evernote
VERSION 1.0
Dec 28, 2015

// AUTHORED BY:
    John Xiao (http://zaishanda.com/)

// UPDATE NOTICES
    ** Follow @jfxiao07 on Twitter, Facebook, Google Plus, and ADN for Update Notices! **

// License
    MIT
*)

(* 
======================================
// MAIN PROGRAM 
======================================
*)

set tabUrl to missing value
set theNote to missing value
set tabTitle to missing value
set activeApp to missing value

tell application "System Events"
    set activeApp to name of application processes whose frontmost is true
    --Don't execute when active window is not chrome or Evernote
    --TODO: optimize this logic check
    if (activeApp as string) is not equal to "Evernote" and (activeApp as string) is not equal to "Google Chrome"  and (activeApp as string) is not equal to "Google Chrome Canary" then
        error number -128
    end if
    --TODO: optimize (activeApp as string)
    tell application process (activeApp as string)
        set tabUrl to value of text field 1 of toolbar 1 of window 1
        -- Make sure start with http or https
        if (characters 4 thru 1 of tabUrl as string) is not equal to "http" then
            set tabUrl to "http://" & tabUrl
        end if
        set tabTitle to (title of window 1)
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
        set notifyTitle to "[" & (get name of (get notebook of theNote)) & "]" & (get title of theNote)
        set addContent to "<br/><br/>" & tabTitle & "<br/>" & "<a href=\"" & tabUrl & "\">" & tabUrl & "</a>"
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