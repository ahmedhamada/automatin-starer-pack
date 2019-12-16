#!/bin/bash



mkdir ../automation_process
mkdir ../automation_process/lists

wget "https://github.com/aboul3la/Sublist3r/blob/master/subbrute/names.txt?raw=true"  --output-document ../automation_process/lists/sublister_names.txt
wget "https://github.com/aboul3la/Sublist3r/raw/master/subbrute/resolvers.txt"  --output-document ../automation_process/lists/resolvers.txt

#278.6 MB
#git clone https://github.com/danielmiessler/RobotsDisallowed.git ../automation_process/lists/RobotsDisallowed


#download svn list
wget https://www.netsparker.com/s/research/SVNDigger.zip
mkdir ../automation_process/lists/svndigger

unzip SVNDigger.zip -d ../automation_process/lists/svndigger
rm SVNDigger.zip


#make our svn 1 file list
svn_directory="../automation_process/lists/svndigger"
cat $svn_directory/context/*.txt $svn_directory/cat/Conf/*.txt $svn_directory/cat/Database/*.txt  $svn_directory/cat/Project/*.txt > ../automation_process/lists/svn_all_files_bruteforce.txt


# (svn files - language folder) + secrets list (forget the source :D) + burp files list + dirsearch file list
mv new_directory_brute_files ../automation_process/lists
mv ../automation_process/lists/new_directory_brute_files/netspark-svn-top10kgitdiger-burp.txt ../automation_process/lists/netspark-svn-top10kgitdiger-burp.txt


#subdomian - the 1 million
# wget "https://github.com/HassanSaad00/SubDomainsEnum/blob/master/jhaddix_commonspeak.txt?raw=true"

#jboss
#https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/jboss.txt

#nginx
#https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/nginx.txt

#apache - 8K
#https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/Apache.fuzz.txt

#1900 - WordlistSkipfish
#https://github.com/fuzzdb-project/fuzzdb/blob/master/discovery/predictable-filepaths/filename-dirname-bruteforce/WordlistSkipfish.txt

#admin list
#Copyright: http://aixoa.blogspot.com/2016/01/admin-page-wordlist.html#ixzz62WCWd1LD

#common DB backups
#https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/Common-DB-Backups.txt

#php common list
#https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/Common-PHP-Filenames.txt




#tests

lines=$(wc -l < ../automation_process/lists/netspark-svn-top10kgitdiger-burp.txt)

if [[ $lines -gt 23000 ]]; then

    echo -e "\nnetspark-svn-top10kgitdiger-burp.txt in in its place :)"
    else
        echo -e "\nnetspark-svn-top10kgitdiger-burp.txt not in its place or something get wrong :("
fi