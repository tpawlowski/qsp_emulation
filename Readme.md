# QSP emulation 

This repository contains code for estimating QSP model using machine learning methods.

## Installation

This code was written and teste on python 3.10. To reproduce environment please install python 3.10 and 
install requirements using pip:

```bash
$ pip install -r requirements.txt
```

The list of direct project dependencies is stored in `requirements.in` file. 

## Usage

Currently, the code is splitted on 5 parts. All notebooks are stored in `notebooks` folder.

1. `01. Generating training dataset (1M patients) using QSP.ipynb` - this notebook generates training dataset 
   using QSP model implemented in R language.
2. `02. Training ML models.ipynb` - this notebook trains and evaluates ML models on generated 
   dataset.