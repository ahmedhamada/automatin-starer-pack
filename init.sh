#!/bin/bash

#the final path - no / at the end
report_path='/var/www/html/reports'

domain='fluix.io'

#result file_name.txt
sites='fluix.io.txt'

logs=$report_path/$domain/'logs.txt'

#make report directory
mkdir $report_path/$domain

chmod 777 $report_path/$domain

echo chmod 777 successfully

#remove the line later
rm start_sublister_aquatone.sh.save*

#export go varible
export PATH=$PATH:/usr/local/go/bin
