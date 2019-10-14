#!/bin/bash

cd ../

mkdir automation_process
cd automation_process
mkdir lists
cd lists

wget "https://github.com/aboul3la/Sublist3r/blob/master/subbrute/names.txt?raw=true"  --output-document sublister_names.txt
wget "https://github.com/aboul3la/Sublist3r/raw/master/subbrute/resolvers.txt"  --output-document resolvers.txt

sublister_names




