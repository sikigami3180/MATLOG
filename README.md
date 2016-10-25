# MATLogica
an interpreter of predicate logic on matlab

## how to use
1. Clone this repository.
2. Launch matlab and move to MATLogica directory.
3. Add fact or chain. Data directory is made into MATLogica directory.
4. Evaluate input. MATLogica return TRUE(1) or FALSE(0).

## Format of inputs
### fact
"predicate,argNum,arg1,arg2,...,argN"
eg: An apple is red. -> "red,1,apple"
    I love cat. -> "love,2,I,cat"

### chain
"predicate,argNum:chain1,cArgNum1,cArg1-1,..,cArg1-M1:...,"
chains are also predicate and use predicate's arg.
cArgs are number of predicate's arg.
If all chains are correct, the predicate is correct.
It discribes correspondence of predicate and chain.
So all cArgs must not be greater than argNum.
eg: If X is apple, X is red. ->"red,1,apple,1"
