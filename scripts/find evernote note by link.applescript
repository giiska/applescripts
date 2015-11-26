tell application "Evernote"
  set myNote to (find note "evernote:///view/2147483647/s224/local/x-coredata://E08796F4-8732-4899-B547-0D37DDDB5043/ENNote/p734/") -- returns a list of notes
  get (title) of myNote
  --tell myNote to append text ""
end tell