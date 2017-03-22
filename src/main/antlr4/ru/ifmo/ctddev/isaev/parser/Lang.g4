grammar Lang;

// starting point
program
    :    functionDef* codeBlock EOF
    ;

codeBlock
    :    (statement)? (';'statement)*;

statement
    :    'return'? ('skip' | whileLoop | cond | forLoop | repeatLoop | functionCall | assignment |  expr)
    ;

assignment
    : variable ':=' expr
    ;
    
whileLoop
    : 'while' expr 'do' codeBlock 'od'
    ;

forLoop
    : 'for' codeBlock ',' expr ','codeBlock 'do' codeBlock 'od';    
 
repeatLoop
    : 'repeat' codeBlock 'until' expr 
    ;    
   
cond
    : 'if' expr 'then' codeBlock elifs ('else' codeBlock)? 'fi'
    ;

elifs
    : (ELIF expr THEN codeBlock)*;


argList
    : expr? ( ',' expr)*
    ;
    
functionCall
    : variable '(' argList ')'
    ;

functionDef
    : 'fun' variable '(' argList ')' 'begin' codeBlock END
    ;
  
/* Logical operations have the lowest precedence. */
expr
    :    atom
         |   ('+'|'-') expr
         |   expr ( '*'| '/'| '%') expr
         |   expr ( '+'|'-')  expr
         |   expr ( '<'|'<='|'>'|'>=') expr
         |   expr ( '=='|'!=') expr
         |   expr '&' expr
         |   expr '!!' expr
         |   expr '|' expr
         |   expr '&&' expr
         |   expr '||' expr
         ;
        
atom
    :    variable | functionCall | Number | '(' expr ')';
    
variable: 
    Var;
    
// LEXER
    
// Keywords    
SKIP_ : 'skip';
WHILE : 'while';    
REPEAT : 'repeat';    
FOR : 'for';    
IF : 'if';  
FUN : 'fun';  
RETURN : 'return';  
DO : 'do';    
THEN : 'then';   
ELSE : 'else';   
UNTIL : 'until';  
BEGIN : 'begin';  
OD : 'od';   
FI : 'fi';    
END : 'end';   
ELIF : 'elif';   

// Accepted characters
fragment Letter   :    [A-Za-z_];
fragment LetterOrDigit   :    [A-Za-z0-9_];
Number   :    [0-9]+;
Var      :    Letter LetterOrDigit*;

// Whitespaces
WS  
    :   [ \t\r\n] -> skip;
    
    