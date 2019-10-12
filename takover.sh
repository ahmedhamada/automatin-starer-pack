#!/bin/bash
source init.sh
cd SubOver && ./subover -l  '/data/www/default/reports/'$domain'/uniq_final.txt' -a
