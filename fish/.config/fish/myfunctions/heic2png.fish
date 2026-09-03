function heic2png
    for f in $argv
        sips -s format png $f --out (string replace -ri '\.heic$' .png $f)
    end
end
