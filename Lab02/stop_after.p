
/*------------------------------------------------------------------------
    File        : stop_after.p
    Purpose     :

    Syntax      :

    Description :

    Author(s)   : Peter
    Created     : Wed Aug 24 10:51:07 EDT 2022
    Notes       :
  ----------------------------------------------------------------------*/
BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ***************************  Main Block  *************************** */
DEFINE VARIABLE iStopAfter AS DECIMAL NO-UNDO.

// 2 second timeout
iStopAfter = 2.

DO STOP-AFTER iStopAfter:
    // make sure we pause long enough to cause the STOP-AFTER to be raised
    PAUSE (2 * iStopAfter) NO-MESSAGE.
END.

CATCH stopCond AS Progress.Lang.StopAfter:
    MESSAGE
        stopCond:GetClass():TypeName
    VIEW-AS ALERT-BOX.
END CATCH.