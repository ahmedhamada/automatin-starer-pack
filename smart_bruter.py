#!/bin/python

"""
smart bruter

corp    <= very important - internal systen

{brute}-section.site.com
{brute}.section.site.com
section-{brute}.site.com

sublister take alot of time to brutefores names.txt 127K - with threads 33

//patterns
any1  => 2,3,4,5,6,7,8,9
-any

//LATER IMPROVEMENT
skip if contain any word from the list 
delete some unnecessary words from the list


final file: final_huge_smart_subdomain_words_list.txt


"""
print  """
python script.py domain.com

"""

import os
import sys

domain=sys.argv[1]
max_subdomain_file_length=1000
final_write_to='/data/www/default/reports/'+domain+'/final_huge_smart_subdomain_words_list.txt'

uniq_final_the_domians_file_path='/data/www/default/reports/'+domain+'/uniq_final.txt'

write = open(final_write_to,'w')

def file_len(fname):
    with open(fname) as f:
        for i, l in enumerate(f):
            pass
    return i + 1


def return_smart_subdomians(phase):
	smart_list = open('/root/tools/lists/250_smart_word.txt','r')
	# smart_list = open('/root/tools/lists/250_smart_word.txt','r')
	for d in smart_list.readlines():
		d = d.strip()
		write.write(d+'-'+phase+"\r\n")
		write.write(phase+'-'+d+"\r\n")
		write.write(d+'.'+phase+"\r\n")

		# print(d+'-'+phase)
		# print(phase+'-'+d) 
		# print(d+'.'+phase)


if file_len(uniq_final_the_domians_file_path) > max_subdomain_file_length:
	print "\033[0;31m===>>> WARNING!!! exit the script because the subdomains lines is bigger than "+str(max_subdomain_file_length)
	quit()

# subdomains = open('/media/root/all/zump_uniq.txt','r')
subdomains = open(uniq_final_the_domians_file_path,'r')
for x in subdomains.readlines():
	subdomains = x.strip()
	if len(subdomains)  <= 0 :
		continue
	subdomains = subdomains.split('.')[0]
	return_smart_subdomians(subdomains)


#os.system("source init.sh && echo $sites")
print " ==> finished the python script"

print"domain="+domain
print """cd massdns
./scripts/subbrute.py /data/www/default/reports/$domain/final_huge_smart_subdomain_words_list.txt $domain | ./bin/massdns -r lists/resolvers.txt -t A -o S -w /data/www/default/reports/$domain/uniq_final_from_smart_list.txt
cd ..
cat /data/www/default/reports/$domain/uniq_final_from_smart_list.txt | cut -d " " -f1 > /data/www/default/reports/$domain/massdns_report_from_smartList_with_dot.txt
sed 's/.$//' /data/www/default/reports/$domain/massdns_report_from_smartList_with_dot.txt > /data/www/default/reports/$domain/massdns_from_smartList_final.txt
print "done"
"""

print "cat /data/www/default/reports/"+domain+"/massdns_from_smartList_final.txt | ./aquatone -ports xlarge -out /data/www/default/reports/"+domain+"/new_screenshots -http-timeout 5000 -threads 50"
print "chmod 555 -R /data/www/default/reports/"+domain
