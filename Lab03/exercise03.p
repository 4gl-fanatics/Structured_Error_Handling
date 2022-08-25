
/*------------------------------------------------------------------------
    File        : exercise03.p
    Purpose     :

    Syntax      :

    Description :

    Author(s)   : Peter
    Created     : Wed Aug 24 14:51:59 EDT 2022
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Lab03.BadThingError FROM PROPATH.
USING Progress.Lang.AppError FROM PROPATH.
USING Progress.Reflect.DataType FROM PROPATH.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
SESSION:ERROR-STACK-TRACE = TRUE.

INT('forty two').

// For a deeper CallStack
//RUN Lab01/avm_throws.p.

CATCH err AS Progress.Lang.Error :
    DEFINE VARIABLE btErr AS BadThingError NO-UNDO.
    // Double-wrapped to show recursion
    btErr = NEW BadThingError(NEW BadThingError(err)).
    RUN printError(btErr).
END CATCH.

PROCEDURE printError:
    DEFINE INPUT PARAMETER pError AS Progress.Lang.Error NO-UNDO.

    DEFINE VARIABLE errLoop AS INTEGER NO-UNDO.
    DEFINE VARIABLE errMax AS INTEGER NO-UNDO.
    DEFINE VARIABLE stackLoop AS INTEGER NO-UNDO.
    DEFINE VARIABLE stackMax AS INTEGER NO-UNDO.
    DEFINE VARIABLE ex AS Progress.Lang.Error NO-UNDO.
    DEFINE VARIABLE errProp AS Progress.Reflect.Property NO-UNDO.
    DEFINE VARIABLE errHeader AS CHARACTER NO-UNDO.
    DEFINE VARIABLE indent AS INTEGER NO-UNDO.

    OUTPUT TO 'error.out'.

    // only do error stuff
    ASSIGN ex        = pError
           errHeader = 'Error(s) raised:'
           indent    = 0
           .
    DO WHILE VALID-OBJECT(ex):
        PUT UNFORMATTED
            errHeader       SKIP
            FILL('~t', indent)
            'Error type: ' ex:GetClass():TypeName SKIP
            .
        ASSIGN errMax = ex:NumMessages.
        DO errLoop = 1 TO errMax:
            PUT UNFORMATTED
                FILL('~t', indent)
                SUBSTITUTE('&1 (&2)':u, ex:GetMessage(errLoop), ex:GetMessageNum(errLoop) ) SKIP
                .
        END.

        IF  TYPE-OF(ex, AppError)
        AND CAST(ex, AppError):ReturnValue NE '':u
        THEN
            PUT UNFORMATTED
                FILL('~t', indent)
                SUBSTITUTE('Return value: &1' , CAST(ex, AppError):ReturnValue)
                SKIP.

        PUT UNFORMATTED FILL('~t', indent) 'Call stack:' SKIP.
        stackMax = NUM-ENTRIES(ex:CallStack, '~n').
        IF NOT SESSION:ERROR-STACK-TRACE THEN
            PUT UNFORMATTED
                FILL('~t', indent + 1) '<off>' SKIP.
        ELSE
        IF stackMax EQ ? THEN
            PUT UNFORMATTED
                FILL('~t', indent + 1) '<empty>' SKIP.
        ELSE
        DO:
            DO stackLoop = 1 TO stackMax:
                PUT UNFORMATTED
                    FILL('~t', indent + 1) ENTRY(stackLoop, ex:CallStack, '~n') SKIP.
            END.
        END.

        ASSIGN errProp = ex:GetClass():GetProperty('InnerError':u).
        // property exists
        IF VALID-OBJECT(errProp)
        // and is of type Progress.Lang.Error
        AND errProp:DataType EQ DataType:Object
        AND Progress.Lang.Class:GetClass(errProp:DataTypeName):IsA(GET-CLASS(Progress.Lang.Error))
        // And is publicly readable
        AND errProp:CanRead
        THEN
            ASSIGN errHeader = FILL('~t', indent) + 'Caused by:'
                   indent    = indent + 1
                   ex        = errProp:Get(ex)
                   .
        ELSE
            ASSIGN ex = ?.
    END.
    FINALLY:
        OUTPUT CLOSE.
    END FINALLY.
END PROCEDURE.