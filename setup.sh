#!/usr/bin/env bash

mkdir -p FACT
cd FACT

echo "===== $(pwd) ====="

python -m venv .
source bin/activate

echo "===== $(python --version) ====="

echo 'Downloading PyTorch (CPU only)'
if [ "$(uname)" == "Darwin" ]; then
    python -m pip install torch torchvision
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    python -m pip install torch==1.3.1+cpu torchvision==0.4.2+cpu -f https://download.pytorch.org/whl/torch_stable.html
fi

echo '===== Cloning repo ====='
git clone git@github.com:dmelis/SENN.git
cd SENN

sed -i 's/0.3.0.post4/0.3.1/g' requirements.txt

echo '===== Installing requirements ====='
python -m pip install -r requirements.txt
python setup.py install
python scripts/main_mnist.py --train