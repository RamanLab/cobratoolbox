COBRA Toolbox lite
==================
This a fork of the [cobratoolbox](https://github.com/opencobra/cobratoolbox) and is intended to be a minimal and lightweight version of it. This repository focuses on the basic functionalities provided by the cobratoolbox.

System Requirements
-------------------

Please follow [this guide](https://github.com/opencobra/cobratoolbox/blob/master/.github/REQUIREMENTS.md) in order to configure your system properly.

Solver Installation
-------------------

The default solver is `glpk` (for `LP` and `MILP`). You can install `TOMLAB`, `IBM ILOG CPLEX`, `GUROBI`, or `MOSEK` by following these **[detailed instructions](https://github.com/opencobra/cobratoolbox/blob/master/.github/SOLVERS.md)**.

Installation
------------

1. Download this repository (the folder `./cobratoolbox-lite/` will be created). You can clone the repository using:
    ````bash
    $ git clone -b cobratoolbox-lite --single-branch https://github.com/RamanLab/cobratoolbox.git cobratoolbox-lite
    ````
    Run this command in `Terminal` (on macOS and Linux) or in `Git Bash` (on Windows) - **not** in Matlab.

2. Change to the folder `cobratoolbox-lite/` and run from Matlab:
    ````Matlab
    >> initCobraToolbox
    ````

3. You can test your installation by running from Matlab:
    ````Matlab
    >> testAll
    ````

How to cite `The COBRA Toolbox`
---------------

When citing `The COBRA Toolbox`, it is important to cite the original paper where an algorithm was first reported, as well as its implementation in `The COBRA Toolbox`. This is important, because the objective of `The COBRA Toolbox` is to amalgamate and integrate the functionality of a wide range of COBRA algorithms and this will be undermined if contributors of new algorithms do not get their fair share of citations. The following is one example how to approach this within the methods section of a paper (**not** the supplemental material please):

*To generate a context-specific model the FASTCORE algorithm [1], implemented in The COBRA Toolbox [2], was employed.*

>[1] = Vlassis N, Pacheco MP, Sauter T (2014) Fast Reconstruction of Compact Context-Specific Metabolic Network Models. PLoS Comput Biol 10(1): e1003424.
>

>[2] = Schellenberger J, Que R, Fleming RMT, Thiele I, Orth JD, Feist AM, Zielinski DC, Bordbar A, Lewis NE, Rahmanian S, Kang J, Hyduke DR, Palsson BØ. 2011 Quantitative prediction of cellular metabolism with constraint-based models: The COBRA Toolbox v2.0. Nature Protocols 6:1290-1307.
>


Disclaimer
----------

*The software provided by the openCOBRA Project is distributed under the GNU GPLv3 or later.  However, this software is designed for scientific research and as such may contain algorithms that are associated with patents in the U.S. and abroad.  If the user so chooses to use the software provided by the openCOBRA project for commercial endeavors then it is solely the user’s responsibility to license any patents that may exist and respond in full to any legal actions taken by the patent holder.*
