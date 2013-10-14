Bot
===

This bot has two sides: interpreters and actions.

Flow:
*   Receive as much as possible from interpreters
*   Match against all actions
*   Perform action with matching data included
*   Repeat


Interpreters
------------

Interpreters read strangely similar to a socket.
They should generally be a socket... I think?

All it really needs is a #read and a #write.
The rest of it will be taken care of by the bot


Actions
-------

Actions are just simple Regex wrappers that also have a #action method.
The method should take an array of matches and some sort of output.
For now the output will just be the connection associated with it.
Since the connection is being passed through, writing back is just output#write.
