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
    File        : CustomError
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : Peter
    Created     : Tue Aug 23 16:04:30 EDT 2022
    Notes       :
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Lang.AppError.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Lab01.CustomError INHERITS AppError:
    /** Returns the program that raised this error **/
    DEFINE PUBLIC PROPERTY CalledFrom AS CHARACTER NO-UNDO
        GET.
        PRIVATE SET.

    CONSTRUCTOR PUBLIC CustomError ( ):
        SUPER ('custom_error').

        THIS-OBJECT:AddMessage('First Error', 10).
        THIS-OBJECT:AddMessage('Second Error', 20).

        THIS-OBJECT:CalledFrom = PROGRAM-NAME(2).
    END CONSTRUCTOR.

END CLASS.