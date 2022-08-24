/*******************************************************************************
MIT License

Copyright (c) 2022 Peter Judge, Consultingwerk Ltd

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice AND this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*******************************************************************************/
/*------------------------------------------------------------------------
    File        : exercise01.p
    Purpose     :

    Syntax      :

    Description :

    Author(s)   : Peter
    Created     : Wed Aug 24 12:05:47 EDT 2022
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.


/* ***************************  Main Block  *************************** */
SESSION:ERROR-STACK-TRACE = no  .

RUN Lab01/throw_custom_class.p.

CATCH err AS Progress.Lang.Error:
    MESSAGE err:GetMessage(1) SKIP(2)
    "CallStack:" SKIP
    err:CallStack SKIP (2)
    "Program-Name(1..3):" skip
    PROGRAM-NAME(1) SKIP
    PROGRAM-NAME(2) SKIP
    PROGRAM-NAME(3) SKIP
    VIEW-AS ALERT-BOX.
END CATCH.

