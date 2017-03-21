####################################################
# README
#
# This script is a cronjob which updates BlastDBs. Define which DBs to update
# in the last lines db=Foobar
#
#
#####################################################
#!/bin/sh

#Enter the path to blastdb
dbpath=/SAN/db/blastdb
#Enter path to store old DBs
dbold=/SAN/db/old.blastdb

#Timestampfunction to archive old DBs
timeStampVariable=$(date +"%Y-%m-%d")

#Function to download DB+
downloadDB(dbName){
	mkdir ${dbpath}/new_${dbName}

	mv ${dbpath}/${dbName} ${dbold}/${timestampv}_${dbName}

	#begin Download
	wget -r -l0 --ftp-user=anonymous --ftp-password=anonymous --directory-prefix=${dbpath}/new_${dbName} ftp://ftp.ncbi.nlm.nih.gov/blast/db/${dbName}*.tar.gz

	#begin extract
	cd ${dbpath}/new_${dbName}/ftp.ncbi.nlm.nih.gov/blast/db/
	ls *.tar.gz | xargs -n1 tar -xzf
	rm -rf *tar.gz
	mkdir ${dbpath}/${dbName}
	mv ${dbName}.* ${dbpath}/${dbName}/
	rm -rf ${dbpath}/new_${dbName}

	#check count of archived DBs and delete oldest if counter higher than 5
	cd ${dbold}
	oldcount="$(ls -d -1 *_${dbName} | wc -l)"
	if [ "$oldcount" -gt 5 ]
		then
		deleteold="$(ls -d -t -1 $PWD/**${dbName} | awk 'NR==1')"
		rm -rf "${deleteold}"
	fi
}

### Call function to download DBs
downloadDB(nt);
downloadDB(nr);
downloadDB(taxdb);

#testing

