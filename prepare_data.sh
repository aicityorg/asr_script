#!/bin/bash

# 03.05.2018 thanh.truong 
# prepare data for waw.scp, text, spk2utt, utt2spk

# Setup relevant folders
WAV_ROOT="/home/kinkin/workspace/kaldi/02.source/kaldi/egs/mytrain/wav"
TRAIN_ROOT="/home/kinkin/workspace/kaldi/02.source/kaldi/egs/mytrain/data/train"
utils="/home/kinkin/workspace/kaldi/02.source/kaldi/egs/mytrain/utils"

# Setup wav folders
if [ ! -d $WAV_ROOT ]; then
  echo "Cannot find wav directory $WAV_ROOT"
  exit 1;
fi
if [ ! -d $TRAIN_ROOT ]; then
  echo "Cannot find wav directory $TRAIN_ROOT"
  exit 1;
fi

echo "Preparing data sets"

# Create wav.scp files
scp="$TRAIN_ROOT/wav.scp"
rm -f "$scp"
echo "Creating $scp"
for d in $(find $WAV_ROOT -maxdepth 1 -type d )
do
	allfile=`ls $d/`
	for one in $allfile
	do
		
		if [ ${one: -4} == ".wav" ]; then
			
			name=`echo "$one" | sed s/.wav//`
			path="$d/$one"		
			name=`echo -e "$name\t\t$path"`

			echo $name >> temp.txt
		fi
	done
	
done
sort temp.txt >> $scp
rm -f temp.txt

#Create text file
textfile="$TRAIN_ROOT/text"
rm -f "$textfile"
echo "Creating $textfile"
for d in $(find $WAV_ROOT -maxdepth 1 -type d -printf '%f\n')
do
  script_file="$d" 
  script_file+="_script.txt"
  
  script_path=$WAV_ROOT
  script_path+="/"
  script_path+="$d"
  script_path+="/"
  script_path+=$script_file
  
  if [ -f "${script_path}" ]; then
  
  	while IFS= read -r line;do
    	echo "$line" | sed -e 's/[',','.','?']//g' >> temp.txt
	done < "$script_path"
  fi
done
sort temp.txt >> $textfile
rm -f temp.txt

#Create utt2spk file
utt2spk="$TRAIN_ROOT/utt2spk"
rm -f "$utt2spk"
echo "Creating $utt2spk"

for d in $(find $WAV_ROOT -maxdepth 1 -type d -printf '%f\n')
do
 
  	sub_folder=$WAV_ROOT
  	sub_folder+="/"
  	sub_folder+="$d"
  	if [ -d "$sub_folder" ]; then
    	allfile=`ls $sub_folder/`
		for one in $allfile
		do

			if [ ${one: -4} == ".wav" ]; then			
				name=`echo "$one" | sed s/.wav//`
				name=`echo -e "$name\t\t$d"`
				echo $name >> temp.txt
			fi
		done
	fi
	
done
sort temp.txt >> $utt2spk
rm -f temp.txt

#Create spk2utt file
spk2utt="$TRAIN_ROOT/spk2utt"
rm -f "$spk2utt"
echo "Creating $spk2utt"
cat "$utt2spk" | $utils/utt2spk_to_spk2utt.pl > "$spk2utt" 

echo "--> Data preparation succeeded"
exit 0
