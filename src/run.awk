#!/usr/bin/awk -f
BEGIN {
    FS = "|"
    max_duration = 0
    security_code = ""
    max_mission_id = ""
}

# Skip the header line
NR == 1 { next }

{
    # Remove leading/trailing whitespace
    gsub(/^[ \t]+|[ \t]+$/, "", $0)
    
    # Normalize internal whitespace to a single space
    $1 = $1

    # Remove leading/trailing whitespace from duration field (field 6)
    gsub(/^[ \t]+|[ \t]+$/, "", $6)
    duration = $6 + 0
    
    # Remove leading/trailing whitespace from security code field (field 8)
    gsub(/^[ \t]+|[ \t]+$/, "", $8)
    # Remove leading/trailing whitespace from security code field (field 2)
    gsub(/^[ \t]+|[ \t]+$/, "", $2) 

    # Check if this duration is greater than current max
    if (duration > max_duration) {
        max_duration = duration
        security_code = $8
        max_mission_id = $2
    }
}

END {
    print "Security code of mission (" max_mission_id") with maximum duration (" max_duration " days): " security_code
}
