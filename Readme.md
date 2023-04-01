# QSP emulation 

This repository contains code for estimating QSP model using machine learning methods.

## Installation

### Installation using `pip` 
This code was written and teste on python 3.10. To reproduce environment please install python 3.10 and 
install requirements using pip:

```bash
$ pip install -r requirements.txt
```

The list of direct project dependencies is stored in `requirements.in` file. 

Generation of fata point require R interpreter and `deSolve` package.

### Installation using `conda`/`mamba`

We have prepared `environment.yml` file with both python and R dependencies. 
Base on your preference for `conda` or `mamba` you can install all dependencies using one of the following commands. 


To install all dependencies using `conda` please run:

```bash
$ conda env create --file=environment.yml -n qsp_emulation
```

To install all dependencies using `mamba` please run:

```bash
$ mamba env create --file=environment.yml -n qsp_emulation
```

Because of performance we suggest to use `mamba` instead of `conda`.

## Usage

Currently, the code is splitted on 5 parts. All notebooks are stored in `notebooks` folder.

1. `01. Generating training dataset (1M patients) using QSP.ipynb` - this notebook generates training dataset 
   using QSP model implemented in R language.
2. `02. Training ML models.ipynb` - this notebook trains and evaluates ML models on generated 
   dataset.