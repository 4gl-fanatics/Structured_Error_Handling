
/*------------------------------------------------------------------------
    File        : return_error_obj.p
    Purpose     :

    Syntax      :

    Description :

    Author(s)   : Peter
    Created     : Tue Aug 23 15:22:40 EDT 2022
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

DEFINE VARIABLE err AS Progress.Lang.AppError NO-UNDO.

err = NEW Progress.Lang.AppError ('return from return_error_obj').
err:AddMessage('one hundred', 100).
err:AddMessage('two hundred', 200).
err:AddMessage('three hundred', 300).

RETURN ERROR err.
