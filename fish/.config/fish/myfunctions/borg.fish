function borg --wraps=borg
    # Inject the BORG_PASSPHRASE into env when calling borg.
    set -l entry "borg/"(hostname -s)
    if type -q pass; and pass show $entry >/dev/null 2>&1
        set -fx BORG_PASSCOMMAND "pass show $entry"
    end
    command borg $argv
end
