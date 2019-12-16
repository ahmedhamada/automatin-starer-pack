#!/bin/bash
source init.sh


cd SubOver
./SubOver -l  $report_path/$domain/uniq_final.txt -o $report_path/$domain/takover.txt -a
cd ..
