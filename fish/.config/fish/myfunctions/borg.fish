function borg --wraps=borg
    set -l entry "borg/"(hostname -s)
    echo $entry
    if type -q pass; and pass show $entry >/dev/null 2>&1
        set -fx BORG_PASSCOMMAND "pass show $entry"
    end
    command borg $argv
end
