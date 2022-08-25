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
    File        : BadThingError
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : Peter
    Created     : Wed Aug 24 14:25:20 EDT 2022
    Notes       :
  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Lab03.BadThingError INHERITS Progress.Lang.AppError:

    DEFINE PUBLIC PROPERTY InnerError AS Progress.Lang.Error NO-UNDO
    GET.
    SET.

    CONSTRUCTOR PUBLIC BadThingError(INPUT pError AS Progress.Lang.Error):
        ASSIGN THIS-OBJECT:InnerError = pError
               THIS-OBJECT:ReturnValue = 'Whoops'
               .
        AddMessage('A bad thing happened!', -42).
    END CONSTRUCTOR.

    METHOD OVERRIDE PUBLIC CHARACTER ToString():
        RETURN SUBSTITUTE("&1 Cause: &2",
                         THIS-OBJECT:GetMessage(1),
                         THIS-OBJECT:InnerError:GetMessage(1)).
    END METHOD.

END CLASS.