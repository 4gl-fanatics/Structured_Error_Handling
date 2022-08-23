
/*------------------------------------------------------------------------
    File        : return_error_character.p
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


RETURN ERROR 'from return_error_character'.
