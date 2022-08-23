
/*------------------------------------------------------------------------
    File        : return_error_new.p
    Purpose     :

    Syntax      :

    Description :

    Author(s)   : Peter
    Created     : Tue Aug 23 15:22:40 EDT 2022
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ***************************  Main Block  *************************** */


RETURN ERROR NEW Progress.Lang.AppError('from return_error_new', 0).
