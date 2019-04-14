awk -F: 'BEGIN{OFS="+"}{ print $5, $0 }' $1 | sort | sed -E 's/^[A-Z].*[ ]{1}[A-Z].*[+]//'
