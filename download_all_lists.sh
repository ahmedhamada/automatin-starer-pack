#!/bin/bash

cd ../

mkdir automation_process
cd automation_process
mkdir lists
cd lists

wget "https://github.com/aboul3la/Sublist3r/blob/master/subbrute/names.txt?raw=true"  --output-document sublister_names.txt
wget "https://github.com/aboul3la/Sublist3r/raw/master/subbrute/resolvers.txt"  --output-document resolvers.txt


git clone https://github.com/danielmiessler/RobotsDisallowed.git



#download svn list
wget https://www.netsparker.com/s/research/SVNDigger.zip
mkdir svndigger
mv SVNDigger.zip svndigger
cd svndigger
unzip svndigger
rm SVNDigger.zip
cd ..


#make our svn 1 file list
cat svndigger/context/*.txt svndigger/cat/Conf/*.txt svndigger/cat/Database/*.txt  svndigger/cat/Project/*.txt > svn_all_files_bruteforce.txt

#svn + secrets + burp

#subdomian - the 1 million
wget "https://github.com/HassanSaad00/SubDomainsEnum/blob/master/jhaddix_commonspeak.txt?raw=true"

#jboss
https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/jboss.txt
#nginx
https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/nginx.txt
#apache - 8K
https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/Apache.fuzz.txt

#1900 - WordlistSkipfish
https://github.com/fuzzdb-project/fuzzdb/blob/master/discovery/predictable-filepaths/filename-dirname-bruteforce/WordlistSkipfish.txt


#admin list
Copyright: http://aixoa.blogspot.com/2016/01/admin-page-wordlist.html#ixzz62WCWd1LD

#common DB backups
https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/Common-DB-Backups.txt

#php common list
https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/Common-PHP-Filenames.txt

#burp files list + (svn files - language folder) + secrets list + dirbuster list
