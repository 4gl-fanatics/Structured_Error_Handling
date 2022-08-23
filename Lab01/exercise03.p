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
    File        : exercise03.p
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : Peter Judge,. Consultingwerk Ltd
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Progress.Lang.AppError FROM PROPATH.

/* ***************************  Main Block  *************************** */
DEFINE VARIABLE myAppErr AS AppError NO-UNDO.

UNDO, THROW NEW AppError().

// ReturnValue only
UNDO, THROW NEW AppError('error message 1').
// Message only
UNDO, THROW NEW AppError('error message 2', 0).

// Messages and returnvalue
/*
myAppErr = NEW AppError('error message 3').
myAppErr:AddMessage('1 msg',  1).
myAppErr:AddMessage('2 msg',  2).
myAppErr:AddMessage('3 msg',  ?).
UNDO, THROW myAppErr.
*/

CATCH apperr AS Progress.Lang.AppError :
    MESSAGE
    'Caught Progress.Lang.AppError' SKIP
    'Return value: ' apperr:ReturnValue SKIP
    'Num messages: ' apperr:NumMessages SKIP
    'Message text: ' apperr:GetMessage(1) SKIP
    'Message num: ' apperr:GetMessageNum(1)
    VIEW-AS ALERT-BOX.
END CATCH.

CATCH err AS Progress.Lang.Error :
    MESSAGE
    'Caught Progress.Lang.Error' SKIP
    'Num messages: ' err:NumMessages SKIP
    'Message text: ' err:GetMessage(1) SKIP
    'Message num: ' err:GetMessageNum(1)
    VIEW-AS ALERT-BOX.
END CATCH.

