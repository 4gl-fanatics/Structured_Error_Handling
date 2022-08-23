
/*------------------------------------------------------------------------
    File        : called.p
    Purpose     :

    Syntax      :

    Description :

    Author(s)   : Peter
    Created     : Tue Aug 23 15:22:40 EDT 2022
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Progress.Lang.AppError FROM PROPATH.

/* ***************************  Main Block  *************************** */

PROCEDURE undo_throw:
    UNDO, THROW NEW Progress.Lang.AppError('from undo_throw', 0).
END PROCEDURE.

PROCEDURE return_error_new:
    RETURN ERROR NEW Progress.Lang.AppError('from return_error_new', 0).
END PROCEDURE.

PROCEDURE retucalled.prn_error_obj:
    DEFINE VARIABLE err AS Progress.Lang.AppError NO-UNDO.

    err = NEW AppError ('return from return_error_obj').
    err:AddMessage('one hundred', 100).
    err:AddMessage('two hundred', 200).
    err:AddMessage('three hundred', 300).

    RETURN ERROR err.
END PROCEDURE.

PROCEDURE avm_throws:
    INT('forty two').
END PROCEDURE.