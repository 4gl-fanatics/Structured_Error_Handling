
/*------------------------------------------------------------------------
    File        : exercise01.p
    Purpose     :

    Syntax      :

    Description :

    Author(s)   : Peter
    Created     : Wed Aug 24 14:26:26 EDT 2022
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Lab03.BadThingError FROM PROPATH.
USING Progress.Lang.AppError FROM PROPATH.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
undo, THROW NEW BadThingError(NEW AppError('inner', 0)).

CATCH btErr AS BadThingError:
    MESSAGE
    btErr
    VIEW-AS ALERT-BOX.
END CATCH.