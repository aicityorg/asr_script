#01/05/2018 thanh.truong
#make all necessary folder in train 

TRAIN_ROOT='/home/kinkin/workspace/kaldi/02.source/kaldi/egs'
MY_TRAIN_FOLDER_NAME='mytrain'
MY_WAV_FOLDER_NAME='wav'
WAV_SOURCE_FOLDER='/home/kinkin/workspace/kaldi/03.data/vietnam/voice_350h_origin_kaldi/.'
cd $TRAIN_ROOT
if [ ! -d $MY_TRAIN_FOLDER_NAME ]; then
    	mkdir $MY_TRAIN_FOLDER_NAME

	cd $MY_TRAIN_FOLDER_NAME

	ln -s ../wsj/s5/steps .
	ln -s ../wsj/s5/utils .
	ln -s ../../src .

	cp ../wsj/s5/path.sh .
	cp ../wsj/s5/cmd.sh . 
	cp ../wsj/s5/run.sh .

	# since the mycorpus directory is a level higher than wsj/s5, we need to edit the path.sh file

	cd $TRAIN_ROOT 
	cd  $MY_TRAIN_FOLDER_NAME

	mkdir exp
	mkdir conf
	mkdir data

	cd data
	mkdir train
	mkdir lang
	mkdir local

	cd local
	mkdir lang

fi

# show folder tree
cd $TRAIN_ROOT 
cd  $MY_TRAIN_FOLDER_NAME
tree

#make folfer for storing wav file

cd $TRAIN_ROOT 
cd  $MY_TRAIN_FOLDER_NAME
if [ ! -d $MY_WAV_FOLDER_NAME ]; then
	mkdir $MY_WAV_FOLDER_NAME
fi

#copy all wav file to my wav folder
cd $MY_WAV_FOLDER_NAME
cp -r $WAV_SOURCE_FOLDER .

