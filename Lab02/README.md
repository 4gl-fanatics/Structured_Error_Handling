# Lab02: Stop conditions; call- and message stacks #

If you are using OpenEdge 11.7, then make sure that you have `-catchStop 1` on the command-line when running the exercises in this lab. This is not necessary for OE 12.0+ but will do no harm either.

# Exercise 1: call- and message stacks #
1. Create a new .P. Add a line setting the value of `SESSION:ERROR-STACK-TRACE` to `TRUE`.
2. Run any of the program from Lab01, Exercise 1 that throws an error. The error should ideally not be raised in the .P you're editing.
3. Add a `CATCH` block to catch this type, and message the caught error's `CallStack` property value.
4. Change the value of of `SESSION:ERROR-STACK-TRACE` to `FALSE` and run the program again.

## Results ##

When comparing the error's `CallStack` value to the `PROGRAM-NAME()` output, it's important to note that the `CallStack` is at the point that the error was raised; `PROGRAM-NAME()` is from where that function was called.

When ERROR-STACK-TRACE = TRUE, you should see something similar to the below. The `CATCH` block used for this is
```
CATCH err AS Error:
    MESSAGE err:GetMessage(1) SKIP(2)
    "CallStack:" SKIP
    err:CallStack SKIP (2)
    "Program-Name(1..3):" SKIP
    PROGRAM-NAME(1) SKIP
    PROGRAM-NAME(2) SKIP
    PROGRAM-NAME(3) SKIP
    VIEW-AS ALERT-BOX.
END CATCH.
```

```
---------------------------
Message (Press HELP to view stack trace)
---------------------------
First Error


CallStack:
Lab01/throw_custom_class.p at line 21  (C:\Work\projects\structured-error-handling\Lab01\throw_custom_class.r)
C:\Work\projects\structured-error-handling\Lab02\exercise01.p at line 50  (C:\Work\projects\structured-error-handling\Lab02\exercise01.r)


Program-Name(1..3):
C:\Work\projects\structured-error-handling\Lab02\exercise01.p
adecomm/_runcode.p
C:\Progress\OpenEdge125_64\oeide\eclipse\plugins\com.openedge.pdt.debug.core_12.5.1.00\abl\_debuglauncher.p
---------------------------
OK   Help
---------------------------
```

When ERROR-STACK-TRACE = FALSE
```
---------------------------
Message (Press HELP to view stack trace)
---------------------------
First Error


CallStack:
?


Program-Name(1..3):
C:\Work\projects\structured-error-handling\Lab02\exercise01.p
adecomm/_runcode.p
C:\Progress\OpenEdge125_64\oeide\eclipse\plugins\com.openedge.pdt.debug.core_12.5.1.00\abl\_debuglauncher.p
---------------------------
OK   Help
---------------------------
```




https://github.com/progress/ADE/blob/release-12.5.x/corelib/OpenEdge/Logging/Format/ErrorFormat.cls

WriteStack method
https://github.com/progress/ADE/blob/913533dd12f3c1944b13e126e647b07d4bc99274/corelib/OpenEdge/Logging/Format/ErrorFormat.cls#L132

InnerError
https://github.com/progress/ADE/blob/913533dd12f3c1944b13e126e647b07d4bc99274/corelib/OpenEdge/Logging/Format/ErrorFormat.cls#L116

InnerStop
https://github.com/progress/ADE/blob/913533dd12f3c1944b13e126e647b07d4bc99274/corelib/OpenEdge/Logging/Format/ErrorFormat.cls#L91

# Exercise 2: "Stop errors" #

1. Create a .P that runs a non-existent .P
2. Add a `CATCH` block and message the error type - using `err` or `err:ToString()` and the first message. You should see an error 293 for the message.
3. The type you are catching can be `Progress.Lang.Error` or `Progress.Lang.StopError` , even though the latter does not really add anything.
4. If you now run with `-catchStop 0` on the command-line, the "classic" behaviour applies and you will now see your message, but rather a standard OpenEdge message.





# Exercise 3: Stop conditions, user interrupts and lock waits #


## STOP raised ##
1. Create a .P. Add the `STOP` statement.
2. Add a `CATCH` block and message information from the caught stop condition.


## STOP-AFTER raised ##
1. Create a .P. Add some code that will raise the `STOP-AFTER` condition. A simple example of this is in `Lab02/stop_after.p`.
2. Add a `CATCH` block and message information from the caught stop condition.


## Lock wait timeout raised ##
1. Make that a server is running for the Sports2000 database, and that your editor has a connection to this db.
2. Create a .P and find a record - any record - with `EXCLUSIVE-LOCK`. Do *not* use the `NO-WAIT` clause.
3. Add a `PAUSE` statement after the `FIND`, to emulate a "bad lock". Make sure the program pauses long enough to exceed the lock wait timeout value (`-lkwtmo`).
4. Add a `CATCH` block for the `Progress.Lang.LockConflict` class. catching the `Progress.Lang.Stop` class will work but does not have the same information available.
5. Run the program. Make sure that the Sports2000 db is connected and that the session is started with a short `-lkwtmo` value (the minimum is 10 seconds). You should see the pause.
6. Run the program again. You should see a message box for error 2624 (in the second session). Do *not* press the Cancel button. After ~10 seconds, this message will disappear and you will see the message from your `CATCH` block.

### Notes ###
- The LockConflict class has properties showing the `TableName`, `User` and `Device` for the user holding the lock.
- Showing (or logging) the `CallStack` can be useful for finding exactly which query is holding the lock.
- Using `NO-WAIT` in the query disables the lock wait timeout




https://docs.progress.com/bundle/openedge-startup-and-parameter-reference/page/Lock-Timeout-lkwtmo.html?labelkey=product_openedge_125

Use -lkwtmo 10 (min val)



https://docs.progress.com/bundle/abl-reference/page/Progress.Lang.LockConflict-class.html

https://docs.progress.com/bundle/abl-reference/page/Progress.Lang.UserInterrupt-class.html

Not implementing Progress.Lang.Error
Progress.Lang.Stop              - STOP Statement
Progress.Lang.LockConflict      - -lkwtmo exceeded
Progress.Lang.StopAfter         - STOP-AFTER exceeded
Progress.Lang.UserInterrrupt    - CTRL-BREAK

Progress.Lang.SysError derived (ABL runtime error)
Progress.Lang.StopError         - RUN invalid.p, etc.