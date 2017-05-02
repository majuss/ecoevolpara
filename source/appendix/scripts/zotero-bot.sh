#!/bin/bash
channel=\"#literature\";
username=\"zotero_bot\";
icon_emoji=\":cow:\";
URL='https://hooks.slack.com/services/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'


(
	feedstail -e -i 30 -r -f {title}__{author}__{link} -u "https://api.zotero.org/groups/484592/items/top?start=0&limit=3&format=atom&v=1" |
	while read TEXT; do
    	echo curl -s -X POST --data-urlencode \'payload={\"channel\": $channel, \"username\": $username, \"text\": \"$TEXT\", \"icon_emoji\": $icon_emoji}\' $URL | sh
    	echo $TEXT >> /tmp/slack-zotero.log
    	date >> /tmp/slack-zotero.log
   		sleep 2
	done
	exit 0
) & pid=$!

(sleep 604800) && kill -9 $pid



#!/bin/bash
function runBot(){
	(
		while true; do
			echo "lol" >> /tmp/testing.txt
	) & pid=$!

(sleep 604800) && kill -9 $pid

runBot()
}

runBot()




while true
	do runBOt() & pid=$!
	sleep 604800 && kill -9 $pid
done



#!/bin/bash
function echo(){
	echo "lol" >> /tmp/testing.txt
	sleep 5
}

while true
	do (echo()) & pid=$!
	sleep 10 && kill -9 $pid
done




(sleep 5) & pid=$!





