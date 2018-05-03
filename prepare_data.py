#! /usr/bin/env python

import os
import os.path
import sys

# 01/05/2018 thanh.truong
# create all file:
# text
# segments
# wav.scp
# utt2spk
# spk2utt
TRAIN_ROOT = '/home/kinkin/workspace/kaldi/02.source/kaldi/egs'
MY_TRAIN_FOLDER_NAME = 'mytrain'
MY_WAV_FOLDER_NAME = 'wav'

wav_folder = TRAIN_ROOT + '/' + MY_TRAIN_FOLDER_NAME + '/' + MY_WAV_FOLDER_NAME
train_folder = TRAIN_ROOT + '/' + MY_TRAIN_FOLDER_NAME + '/' + 'data/train'

zeroes = []
ones = []
for fn in os.listdir('waves_yesno'):
    if fn.startswith('0'):
        zeroes.append(fn)   # => training set
    elif fn.startswith('1'):
        ones.append(fn)     # => test set

def text(filenames):
    results = []
    for filename in filenames:
        basename = filename.split('.')[0]
        transcript = basename.replace('1', 'YES').replace('0', 'NO').replace('_', " ")
        results.append("{} {}".format(basename.split('.')[0], transcript))

    return '\n'.join(sorted(results))

with open('data/train_yesno/text', 'w') as train_text, open('data/test_yesno/text', 'w') as test_text:
    train_text.write(text(zeroes))
    test_text.write(text(ones))

# finish this method
def wav_scp():
    pass

with open('data/train_yesno/wav.scp', 'w') as train_text, open('data/test_yesno/wav.scp', 'w') as test_text:
    train_text.write(wav_scp(zeroes))
    test_text.write(wav_scp(ones))


# finish this method
def utt2spk():
    pass

with open('data/train_yesno/utt2spk', 'w') as train_text, open('data/test_yesno/utt2spk', 'w') as test_text:
    train_text.write(utt2spk(zeroes))
    test_text.write(utt2spk(ones))


# finish this method
# note that, spk2utt can be generate by using Kaldi util, once you have utt2spk file.
def spk2utt():
    pass