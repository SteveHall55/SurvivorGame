# SurvivorGame

# Description

This app plays out the "Survivor Game" as described here:

You are in a room with a circle of N chairs. The chairs are numbered
sequentially from 1 to N.  At some point in time, the person in chair #1 will be asked to leave. The
person in chair #2 will be skipped, and the person in chair #3 will be asked
to leave. This pattern of skipping one person and asking the next to leave
will keep going around the circle until there is one person left the survivor.

# Animation

The app animates the game.  If there are more than 51 chairs, that's too many for the animation, so
the winner is simply displayed.

# Unit Tests

In the SurvivorGameTests.m file, there is a method named "testGames" which tests the model for several
values of N
