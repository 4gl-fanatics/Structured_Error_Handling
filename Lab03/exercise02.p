
/*------------------------------------------------------------------------
    File        : exercise02.p
    Purpose     :

    Syntax      :

    Description :

    Author(s)   : Peter
    Created     : Wed Aug 24 14:32:13 EDT 2022
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Lab03.BadThingError FROM PROPATH.

/* ***************************  Main Block  *************************** */

RUN ip1.

CATCH err AS BadThingError:
    MESSAGE err:ToString()
    VIEW-AS ALERT-BOX.
END CATCH.

PROCEDURE ip1:
    INT('forty two').

    CATCH err AS Progress.Lang.Error :
        UNDO, THROW NEW BadThingError(err).
    END CATCH.
END PROCEDURE.