#!/bin/bash
# #!/usr/bin/env bash

set -e

ENV_NAME=tagger

echo
echo "
 _______
|__   __|
   | | __ _  __ _  __ _  ___ _ __
   | |/ _  |/ _  |/ _  |/ _ \ '__|
   | | (_| | (_| | (_| |  __/ |
   |_|\__,_|\__, |\__, |\___|_|
             __/ | __/ |
            |___/ |___/
####"
echo "This repo contains the source codes for the publication at https://arxiv.org/abs/1606.06724"
echo "For further detailed mathematical details, please take a look at the Arxiv paper."
echo "For implementation & experimentation details, please open an issue at github!"
echo
echo "####"


echo "Step 1:"
echo "...downloading the dataset:"
if [ -f ./data/freq20-1MNIST_compressed.h5 ]
    then
        echo 'freq20-1MNIST_compressed.h5 exists. Skipping download.'
    else
        wget http://cdn.cai.fi/datasets/freq20-1MNIST_compressed.h5 -P ./data/
fi
if [ -f ./data/freq20-2MNIST_compressed.h5 ]
    then
        echo 'freq20-2MNIST_compressed.h5 exists. Skipping download.'
    else
        wget http://cdn.cai.fi/datasets/freq20-2MNIST_compressed.h5 -P ./data/
fi
if [ -f ./data/shapes50k_20x20_compressed.h5 ]
    then
        echo 'shapes50k_20x20_compressed.h5 exists. Skipping download.'
    else
        wget http://cdn.cai.fi/datasets/shapes50k_20x20_compressed_v2.h5 -P ./data/
        mv ./data/shapes50k_20x20_compressed_v2.h5 ./data/shapes50k_20x20_compressed.h5
fi
echo "...dataset download done!"


echo "Step 2:"
echo "...setup the environment"
pip install -r requirements.txt
echo "...environment setup done!"

echo "Step 3:"
echo "...Checking environment works"
source activate $ENV_NAME
python -c "import theano.tensor as T; x = T.fscalar('x'); y = T.fscalar('y'); z = x + y; assert 2 == int(z.eval({x: 1, y: 1}))"
echo "theano installation seems to be OK"
echo "Omitting Fuels setup validation, please refer to http://fuel.readthedocs.io/en/latest/built_in_datasets.html#environment-variable"
echo "If the problem persists, please open an issue here at github!"
echo "...environment validation done!"



echo "Step 4:"
echo "...Downloading pretrained models"
if [ -f ./pretrained_models/mnist-results/trained_params.npz ]
    then
        echo 'pretrained_models/mnist-results/trained_params.npz exists. Skipping download.'
    else
        wget http://cdn.cai.fi/pretrained-models/freq20-2MNIST_trained_params_20160803.npz -P ./pretrained_models/mnist-results/
        mv ./pretrained_models/mnist-results/freq20-2MNIST_trained_params_20160803.npz ./pretrained_models/mnist-results/trained_params.npz
fi
if [ -f ./pretrained_models/shapes-results/trained_params.npz ]
    then
        echo 'pretrained_models/shapes-results/trained_params.npz exists. Skipping download.'
    else
        wget http://cdn.cai.fi/pretrained-models/shapes50k20x20_trained_params_20160803.npz -P ./pretrained_models/shapes-results/
        mv ./pretrained_models/shapes-results/shapes50k20x20_trained_params_20160803.npz ./pretrained_models/shapes-results/trained_params.npz
fi

echo "Happy tinkering!"
