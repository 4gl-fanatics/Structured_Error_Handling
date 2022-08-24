
/*------------------------------------------------------------------------
    File        : exercise01.p
    Purpose     :

    Syntax      :

    Description :

    Author(s)   : Peter
    Created     : Wed Aug 24 10:52:28 EDT 2022
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
RUN program/does/not/exist.p.

CATCH se AS Progress.Lang.StopError:
    MESSAGE se SKIP
    se:GetMessage(1)
    VIEW-AS ALERT-BOX.
END CATCH.

/* Can also use this CATCH block
CATCH err AS Progress.Lang.Error:
    MESSAGE err SKIP
    err:GetMessage(1)
    VIEW-AS ALERT-BOX.
END CATCH.
*/
