
/*------------------------------------------------------------------------
    File        : undo_throw.p
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


UNDO, THROW NEW Progress.Lang.AppError('from undo_throw', 0).
