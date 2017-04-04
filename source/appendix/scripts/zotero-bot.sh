feedstail -e -i 600 -r -f {title}__{author}__{link} -u "https://api.zotero.org/groups/484592/items/top?start=0&limit=25&format=atom&v=1" | $1;


#!/bin/bash




 >> /tmp/zotero_bot &





channel=\"#testing_bots\";
username=\"zotero_bot\";
icon_emoji=\":cow:\";
URL='https://hooks.slack.com/services/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'
while read TEXT; do
	echo curl -s -X POST --data-urlencode \'payload={\"channel\": $channel, \"username\": $username, \"text\": \"$TEXT\", \"icon_emoji\": $icon_emoji}\' $URL | sh
	echo $TEXT >> $HOME/slack-zotero.log
	date >> $HOME/slack-zotero.log
	sleep 2
done
exit 0


####################

#work with stdout in bash

feedstail -e -i 600 -r -f {title}__{author}__{link} -u "https://api.zotero.org/groups/484592/items/top?start=0&limit=25&format=atom&v=1" | send


i=0; while true; do echo "hello skdf" >> echoed; sleep 3; done | while read echoed; do echo $i >> echoed; sleep 2; ((i++)); done; exit 0


OUTPUT=$(feedstail -e -i 600 -r -f {title}__{author}__{link} -u "https://api.zotero.org/groups/484592/items/top?start=0&limit=25&format=atom&v=1" 2>&1)


####Ele msg

feedstail -e -i 600 -r -f {title}__{author}__{link} -u "https://api.zotero.org/groups/484592/items/top?start=0&limit=25&format=atom&v=1" >> /tmp/zotero_bot &

#!/bin/bash

channel=\"#literature\";
username=\"zotero_bot\";
icon_emoji=\":cow:\";
URL='https://hooks.slack.com/services/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'
while read $(cat /tmp/tables) ; do
    echo curl -s -X POST --data-urlencode \'payload={\"channel\": $channel, \"username\": $username, \"text\": \"$TEXT\", \"icon_emoji\": $icon_emoji}\' $URL | sh
    echo $TEXT >> tmp/slack-zotero.log
    date >> tmp/slack-zotero.log
    sleep 2
done
exit 0