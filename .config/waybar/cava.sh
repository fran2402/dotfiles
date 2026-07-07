#!/bin/sh

bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

i=0
while [ $i -lt ${#bar} ]
do
    dict="${dict}s/$i/${bar:$i:1}/g;"
    i=$((i+1))
done

config_file="/tmp/polybar_cava_config"
cat > "$config_file" <<EOF
[general]
bars = 18

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

last_playing=0

cava -p "$config_file" | while read -r line; do
    now=$(date +%s)

    status=$(playerctl status 2>/dev/null)

    if [ "$status" = "Playing" ]; then
        last_playing=$now
        echo "$line" | sed "$dict"
    elif [ $((now - last_playing)) -lt 15 ]; then
        echo "$line" | sed "$dict"
    else
        echo ""
    fi
done
