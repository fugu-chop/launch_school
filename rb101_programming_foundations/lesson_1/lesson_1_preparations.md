# Lesson 1: Preparations

### PEDAC
PEDAC is a problem solving framework by which we can break down problems in order to solve them more quickly and efficiently. We are derisking our approach by clarifying each step before we start jumping into code - the biggest potential derailer is to solve the wrong problem (e.g. code dead ends).

PEDAC stands for: 
- Understand the Problem
  - Identify expected input and output
  - Make the requirements explicit
  - Identify rules
  - Mental model of the problem (optional)
- Write Examples/Test Cases
  - Validate understanding of the problem
- Data Structure
  - How we represent data that we will work with when converting the input to output (as well as extracting an output)
- Algorithm
  - Steps for converting input to output, in the context of the data structure
- Code 
  - Implementation of Algorithm

This framework helps avoid:
  - Missed requirements
  - Unforeseen Edge Cases
  - Hard to understand code
  - Code that’s difficult to maintain

Useful questions include:
1. Input formats (e.g. data types, validation)?
2. Empty inputs?
3. Output formats?
4. Do I return a new output, or a mutated output?
5. Repetition / Duplication
6. Boundary conditions (e.g. beyond the explicit requirements)
7. Failure states (do I allow Ruby to throw an error, or a default message)?
8. Verify your assumptions!
