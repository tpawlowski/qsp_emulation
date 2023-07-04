# QSP emulation 

This repository contains code for emulating Quantitative Systems Pharmacology (QSP) model using machine learning 
methods.

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

The `environment_freeze.yml` file contains `mamba env export` output to recreate environment in
a exactly the same version, but it also contains Linux specific packages.

## Usage

The code is split to six parts. All notebooks are stored in `notebooks` folder.

1. `01. Generating training dataset (1M patients) using QSP.ipynb` - generates a training dataset 
   of 1000000 patients using QSP model implemented in R language.
2. `02. Training ML models.ipynb` - trains and evaluates Machine Learning (ML) model emulators on 
   generated dataset.
3. `03. Hand-adjusting params and selecting best PCA value.ipynb` - trains and evaluates multiple more 
   variants of `MLPRegressor` emulator, which was selected as best performing in notebook 2.
4. `04. ML Models learning-curves.ipynb` - presents comparison of learning curves of best performing models trained in 
   notebook 2.
5. `05. Best model evaluation.ipynb` - visualizes the absolute and relative error of the best performing emulator
6. `06. Fitting population params.ipynb` - shows the use case of the emulator, by fitting population params to match 
   waterfall plots of virtual and clinical trials.
