s/%+([^%]*)*%+//g
s/#[0-9]{3}-[0-9]{2}-[0-9]{4}/#%%%-%%-%%%%/g
s/\([0-9]{3}\)([ \t]*)[0-9]{3}-[0-9]{4}/(###)\1###-####/g
s/[0-9]{3}-[0-9]{3}-[0-9]{4}/###-###-####/g
s/[^ -]*[0-9]{3}-[0-9]{4}/###-####/g
/^\*[ \t]+.*$/i\
\n* ATTENTION *\n
s/([0-9]*)\/([0-9]*)\/([0-9]{4})/\3-\2-\1/g