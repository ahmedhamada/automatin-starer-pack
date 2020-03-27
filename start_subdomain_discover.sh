#!/bin/bash

#include the varibles
source init.sh

echo $(date) starting massdns >> $logs

# cd massdns

./massdns/scripts/subbrute.py lists/sublister_names.txt $domain | ./massdns/bin/massdns -r lists/resolvers.txt -t A -o S -w $report_path/$domain/massdns_report.txt

# cd ..

cat $report_path/$domain/massdns_report.txt | cut -d " " -f1 > $report_path/$domain/massdns_report_with_dot.txt

sed 's/.$//' $report_path/$domain/massdns_report_with_dot.txt > $report_path/$domain/massdns_final.txt

echo $(date) end massdns >> $logs




#[1] subdomain discover => no bruteforce
echo $(date) start sublister >> $logs
./Sublist3r/sublist3r.py -d $domain -v -t 50 -o $report_path/$domain/$sites
echo $(date) end sublister >> $logs




#[2] heavly subdomain discover

echo $(date) start amass >> $logs

echo start amass

export PATH=$PATH:/snap/bin

amass enum -brute -min-for-recursive 2 -d $domain -o amass.txt

mv amass.txt $report_path/$domain/

echo $(date) end amass >> $logs




#[3]subfinder

echo $(date) start subfinder >> $logs
subfinder -t 50 -v -d $domain -o $report_path/$domain/subfinder.txt --set-config VirustotalAPIKey=733206cfa26930a639d38cf$
echo $(date) start sublister >> $logs

cd /root/tools/




#[4] combine 3  files into one file & unique

echo $(date) start combine 3 files results to final.txt  >> $logs

echo combine amass with aquatone with massdns 3 milllion bruteforce

cat $report_path/$domain/amass.txt $report_path/$domain/$sites  $report_path/$domain/$sites $report_path/$domain/massdns_final.txt $report_path/$domain/subfinder.txt  >> $report_path/$domain/final.txt

echo sort and unique and make file uniq_final.txt

sort $report_path/$domain/final.txt | uniq > $report_path/$domain/uniq_final.txt




echo $(date) start fping - check fping result  >> $logs

echo "==== unique live domains ===="

#fping  -f $report_path/$domain/uniq_final.txt |& grep alive |& cut -d " " -f1 |& tee $report_path/$domain/fping_duplicated.txt

cat $report_path/$domain/uniq_final.txt | httprobe -c 50  | tee $report_path/$domain/fping_duplicated.txt

uniq -u $report_path/$domain/fping_duplicated.txt | tee $report_path/$domain/fping_live_domains.txt ; rm $report_path/$domain/fping_duplicated.txt

echo $(date) end fping >> $logs




#[5] screenshot

#if more than 7000 target - so just screenshot live
lines=$(wc -l < $report_path/$domain/uniq_final.txt)

if [[ $lines -lt 7000 ]]; then

    echo number of lines is : $lines

	echo $(date) start aquatone screenshot >> $logs

	echo $(date) number of lines is $lines which is less than the maximum number >> $logs

	cat $report_path/$domain/uniq_final.txt | aquatone -ports xlarge -out $report_path/$domain -http-timeout 5000 -threads 50
else
        echo $lines is more than 7000
    	echo $(date) aquatone screenshot cannot start >> $logs
fi

echo $(date) end aquatone >> $logs

dig -f $report_path/$domain/massdns_report.txt | grep CNAME >> $report_path/$domain/cnames.txt

chmod -R 777 $report_path/*


echo $(date) finished automation  >> $logs


#[6] waybackmachine then=> generate html report to explore with `link grabber` chrome extention
python waybacktool.py pull --host $domain >> $report_path/$domain/waybackmachine.txt
cat $report_path/$domain/waybackmachine.txt | awk {'print "<a href="$0 ">" $0 "</a><br>" '} > $report_path/$domain/waybackmachine.html

# python waybacktool.py pull --host $domain  >> $report_path/$domain/waybacktool_report.txt



#remove unneccery files
rm $report_path/$domain/massdns_report.txt
rm $report_path/$domain/final.txt