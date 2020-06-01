# Overview

This is a repository containging my work for the CSC594 class at DePaul Univiersity.

# ReactiveNPC

The ReactiveNPC framework is being developed to implement the [Content Theory of Socially Reactive Non-player Characters](https://docs.google.com/document/d/1U1glOjIQG1aq8sUH7y-0v-u7ZLWUt6687OB4Zg8wVgU/edit?usp=sharing). It is written in CLIPS and has three main components:

- **Characters**: this module implements the Characters and the Relationships classes. It also features a series of utility functions to manipulate instances of these classes, along with functions to create characters based on pre-defined templates.
- **Events**: this module implements the Events class and functions to create pre-defined event types. Events usually come along with rules to provoke their direct consequences.
- **Rules**: this module defines the general rules of the content theory. The rules defined here are evaluated for any character classes or event types.

To illustrate the usage of the workflow, a file play.txt is included. This file defines four characters, one relationship between two of them and one event. At the end of the file, the rules are evaluated and a full action scene evolves from there.

The current implementation can be found [here](https://github.com/BrunoCoimbra/CSC594/tree/master/ReactiveNPC).
