#!/usr/bin/env bash

STATE="/tmp/waybar_cpu"

# ---- CPU USAGE ----
read cpu user nice system idle iowait irq softirq steal rest < /proc/stat
total=$((user + nice + system + idle + iowait + irq + softirq + steal))
idle_all=$((idle + iowait))

if [[ -f "$STATE" ]]; then
    read prev_total prev_idle < "$STATE"
    diff_total=$((total - prev_total))
    diff_idle=$((idle_all - prev_idle))

    if (( diff_total > 0 )); then
        usage=$(awk -v dt="$diff_total" -v di="$diff_idle" \
            'BEGIN { printf "%.1f", (dt - di) * 100 / dt }')
    else
        usage="0.0"
    fi
else
    usage="0.0"
fi

echo "$total $idle_all" > "$STATE"

# ---- CPU TEMP ----
get_cpu_temp() {
    for zone in /sys/class/thermal/thermal_zone*/type; do
        if grep -qiE 'cpu|x86_pkg_temp|package' "$zone"; then
            temp_file="${zone%/*}/temp"
            awk '{ printf "%.1f", $1 / 1000 }' "$temp_file"
            return
        fi
    done
    awk '{ printf "%.1f", $1 / 1000 }' /sys/class/thermal/thermal_zone0/temp 2>/dev/null || echo "N/A"
}

temp=$(get_cpu_temp)

# ---- OUTPUT ----
printf ' %s%% %s°' "$usage" "$temp"
