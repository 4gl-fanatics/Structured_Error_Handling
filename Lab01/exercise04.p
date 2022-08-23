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

/* ***************************  Main Block  *************************** */

// Error from Undo, throw.
// modify this to use the correct file name
RUN Lab01/avm_throws.p.
RUN Lab01/throw_custom_class.p.

CATCH apperr AS Progress.Lang.AppError :
    MESSAGE
    'Caught Progress.Lang.AppError' SKIP
    'Return value: ' apperr:ReturnValue SKIP
    'Message text: ' apperr:GetMessage(1) SKIP
    'Message num: ' apperr:GetMessageNum(1)
    VIEW-AS ALERT-BOX.

    RUN show_error_messages(apperr).
END CATCH.

CATCH customerr AS Lab01.CustomError:
    MESSAGE
    'Caught Lab01.CustomError' SKIP
    'Return value: ' customerr:ReturnValue SKIP
    'Message text: ' customerr:GetMessage(1) SKIP
    'Message num: ' customerr:GetMessageNum(1)
    VIEW-AS ALERT-BOX.

    RUN show_error_messages(customerr).
END CATCH .

CATCH syserr AS Progress.Lang.SysError :
    MESSAGE
    'Caught Progress.Lang.SysError'
    'Message text: ' syserr:GetMessage(1) SKIP
    'Message num: ' syserr:GetMessageNum(1)
    VIEW-AS ALERT-BOX.

    RUN show_error_messages(syserr).
END CATCH.


PROCEDURE show_error_messages:
    DEFINE INPUT  PARAMETER pError AS Progress.Lang.Error NO-UNDO.

    DEFINE VARIABLE iLoop AS INTEGER NO-UNDO.
    DEFINE VARIABLE iCnt AS INTEGER NO-UNDO.

    iCnt = pError:NumMessages.
    DO iLoop = 1 TO iCnt:
        MESSAGE
        'Message ' iloop ' of ' iCnt SKIP
        'Message text: ' pError:GetMessage(iLoop) SKIP
        'Message num: ' pError:GetMessageNum(iLoop)
        VIEW-AS ALERT-BOX.
    END.

END PROCEDURE.