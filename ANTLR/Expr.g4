grammar Expr;

// ***Lexing rules***

ID      : [a-zA-Z]+ ;   // Variable names (only alphabetic)
INT     : [0-9]+ ;
NEWLINE : '\r'? '\n' ;
WS      : [ \t]+ -> skip ; // Ignore whitespace

MUL : '*' ;
DIV : '/' ;
ADD : '+' ;
SUB : '-' ;
ASSIGN : '=' ;  // Assignment operator

// ***Parsing rules ***

/** The start rule */
prog: stat+ ;

stat: expr NEWLINE              # printExpr
    | ID ASSIGN expr NEWLINE    # assign
    | NEWLINE                   # blank
    ;

expr: expr op=( '*' | '/' ) expr   # MulDiv
    | expr op=( '+' | '-' ) expr   # AddSub
    | INT                          # int
    | ID                           # id  // Variable reference
    | '(' expr ')'                 # parens
    ;
