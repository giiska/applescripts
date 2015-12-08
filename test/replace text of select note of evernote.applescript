tell application "Evernote"
    try
        set theNotes to selection
        set theNote to first item in theNotes

        set noteHTML to (HTML content of item 1 of theNote)
        log noteHTML
        --return
        set editHTML to noteHTML & "<br><br>--------------------<br><br><br>"
        set (HTML content of item 1 of theNote) to editHTML

    end try
end tell