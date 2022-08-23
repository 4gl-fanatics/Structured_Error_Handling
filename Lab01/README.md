# Summary #
This set of exercises throws errors in various ways.

# Exercise 01 #
1. Create a series of .P's, each of which uses a different mechanism to throw an error. Make sure that the .P has the `BLOCK-LEVEL ON ERROR UNDO, THROW.` directive, to ensure that the error is thrown back to the caller.
2. The procedures should do one of the following (ie just throw one error from each .P).
    1. `UNDO, THROW <error>`
    2. `RETURN ERROR NEW  <error>`
    3. `RETURN ERROR <string>`
    4. Create  <error> and `RETURN ERROR <error>`
    5. Generate an ABL error (hint: the `INT` or `DATE` or similar functions that accept character inputs)
    6. Throws an instance of the provided `Lab01.CustomError` class. When creating this class, use the default , no-argument, constructor.
3. Edit the provided `Lab01/exercise01.p` to run each of the .P's after you've created them


## Results ##
Each .P that is run should show messages like below. The message texts shown will depend on how the error was constructed (what values were passed in).


```
---------------------------
Message (Press HELP to view stack trace)
---------------------------
Caught Progress.Lang.Error
Message text:  ** Invalid character in numeric input f. (76)
Message num:  76
---------------------------
OK   Help
---------------------------
```


## Adding NO-ERROR ##
1. Add `NO-ERROR` to the `RUN` statement. Run the program again. You will see no messages.
2. If you now add a message checking the `ERROR-STATUS` handle after the `RUN` you will see the error message texts from the error thrown.

```
MESSAGE
'ERROR-STATUS ERROR: ' ERROR-STATUS:ERROR SKIP
'ERROR-STATUS GET-MESSAGE(1): ' ERROR-STATUS:GET-MESSAGE(1) SKIP
'ERROR-STATUS GET-NUMBER(1): ' ERROR-STATUS:GET-NUMBER(1) SKIP
VIEW-AS ALERT-BOX.

```

## Results ##

You should see something like the below

```
---------------------------
Message (Press HELP to view stack trace)
---------------------------
ERROR-STATUS ERROR:  yes
ERROR-STATUS GET-MESSAGE(1):  ** Invalid character in numeric input f. (76)
ERROR-STATUS GET-NUMBER(1):  76
---------------------------
OK   Help
---------------------------
```


# Exercise 02 #
1. Open the `Lab01/CustomError.cls` class in your editor. Notice the `CalledFrom` property, that returns the program that threw the error.
2. Open `Lab01/exercise02.p` in the editor, and modify the RUN statement to call the program created in exercise 1, that throws an instance of the CustomError. If you are using PDSOE, you may see a warning when checking syntax; please ignore this.
3. Notice the `CATCH` block for `Lab01.CustomError`, that displays the value of the `CalledFrom` property.
4. Run `Lab01/exercise02.p` . Which message do you see? Does it include the `CalledFrom` property value?
5. The order of the `CATCH` blocks is important here - edit the code in `Lab01/exercise02.p` so that the `CATCH` block for the CustomError is before the `CATCH` block for more generalised AppErrors.
6. Run `Lab01/exercise02.p`  again.


## Results ##
You should now see a message like below.

```
---------------------------
Message (Press HELP to view stack trace)
---------------------------
CAUGHT LAB01.CUSTOMERROR


Called from:  Lab01/throw_custom_class.p
Return value:  custom_error
Message text:  First Error
Message num:  10
---------------------------
OK   Help
---------------------------
```

# Exercise 03 #
1. Create a new .P (eg Lab01/exercise03.p)
2. Write a `CATCH` block for AppErrors that shows the caught AppError's `ReturnValue` value, the `NumMessages` value and the first message (ie `GetMessage(1)` and `GetMessageNum(1)` ).
3. Throw a few AppErrors
    1. One where you pass in one parameter to the constructor, a character string
    2. One where you pass in two parameters, a character string and a number (>=0 )
    3. One where you pass no values into the constructor
4. Take note of what you see.
    Error | NumMessages | GetMessage(1) | Return Value
    ---- | ---- | ---- | ----
    3.1 | 0 | empty | The string passed to the constructor
    3.2 | 1 | The string passed to the constructor | empty
    3.3 | 0 | empty | empty
5. Add a CATCH block for Progress.Lang.Error. Display the caught Error's `NumMessages` value and the first message (ie `GetMessage(1)` and `GetMessageNum(1)` ).
6. Remove (or comment out) the CATCH for AppError.
7. Run the program. Note that only for error 3.2 do you see anything meaningful.

