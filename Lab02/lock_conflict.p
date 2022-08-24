
/*------------------------------------------------------------------------
    File        : lock_conflict.p
    Purpose     :

    Syntax      :

    Description :

    Author(s)   : Peter
    Created     : Wed Aug 24 11:39:42 EDT 2022
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
FIND FIRST Customer EXCLUSIVE-LOCK NO-ERROR .

PAUSE 30.


CATCH stopLock AS Progress.Lang.LockConflict:
    MESSAGE
        stopLock:Device SKIP
        stopLock:TableName SKIP
        stopLock:User SKIP
    VIEW-AS ALERT-BOX.

END CATCH.
