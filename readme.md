# ABM: a collection of Mata classes for creating Agent Based models

## Description
**abm** contains a number of Mata classes intended to help manage various aspects of an  Agent Based model. An Agent Based Model is a simulation in which agents, that each follow simple rules, interact with one another and thus produce a often surprising outcome at the macro level. The purpose of an ABM is to explore mechanisms through which actions of the individual agents add up to a macro outcome, by varying the rules that agents have to follow or varying with whom the agent can interact (i.e. varying the network).

Implementing a new ABM will always require that person developing the ABM does some programming, but many tasks will be similar across ABMs. For example, in many ABMs the agents live on a square grid (like a chessboard), and can only interact with their neighbours. The **abm_grid** class, which is part of the ABM package contains a set of Mata functions that will do those task. Alternatively, the agents could live in a network, and the **abm_nw** is there to handle that case. 

## Requirements and use
This requies [Stata](www.stata.com) version 15. The easiest way to install this is using E. F. Haghish's [github](https://haghish.github.io/github/) command. After you have installed that, you can install **abm** by typing in Stata: `github install maartenteaches/abm`. Alternatively, **abm** can be installed without the **github** command by typing in Stata `net install abm, from("https://raw.githubusercontent.com/maartenteaches/abm/release")`. Both will install the Mata library  with the help-files, but not the source code. The source code is available on this repository. 