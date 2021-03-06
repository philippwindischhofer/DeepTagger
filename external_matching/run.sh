#!/bin/bash

# for local testing
JOB_ID=generator_test
JOB_DESC="trains a 128/1 LSTM with all track parameters, 150000 as training set length, 1000 epochs, batch size = 1000, SGD, LR = 0.009, decay = 1e-6, momentum = 0.9"

# for saving the output
OUTDIR=$PROJECT_HOME/RNN_out_external_matching/${JOB_ID}
echo $OUTDIR
mkdir -p $OUTDIR
echo $JOB_DESC
echo $JOB_DESC > $OUTDIR/desc.txt

# to specify the model topology and the jet / track parameters accessible to the network
# number of nodes per layer
NODES=128
LAYERS=1
EPOCHS=1000
TRAINING_LENGTH=150000

# number of tracks (-1 ... use all that are available)
TRACKS=-1

# which track parameters are passed on to the network (as their indices)
# [ "Track_pt", "Track_eta", "Track_phi", "Track_dxy", "Track_dz", "Track_IP", "Track_IP2D", "Track_length" ]
PARAMETERS="0 1 2 3 4 5 6 7"

echo "starting"

# write all output files back here
python $PROJECT_HOME/external_matching/RNNClassifier-HDF-ext.py `echo "$OUTDIR $EPOCHS $TRAINING_LENGTH $NODES $LAYERS $TRACKS $PARAMETERS"` > $OUTDIR/log.txt
