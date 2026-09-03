function radio --description "Play internet radio by tag"

    set -l tag lofi
    if set -q argv[1]
        set tag $argv[1]
    end

    set -l url (curl -s \
        "https://de1.api.radio-browser.info/json/stations/search?tag=$tag&limit=80&order=clickcount&reverse=true&hidebroken=true" \
        | jq -r '.[] | select(.bitrate >= 128) | "\(.bitrate)k  \(.name)\t\(.url_resolved)"' \
        | fzf --delimiter='\t' --with-nth=1 --prompt="$tag> " \
        | cut -f2)

    if test -n "$url"
        mpv --no-video --term-status-msg='♪ ${media-title}' $url
    end

end
