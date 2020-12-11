grammar IsiLang;

// Vou comentar e explicar cada uma das coisas depois com calma 

prog : 'programa' bloco 'fimprog';

bloco : (cmd)+;

cmd : cmdLeitura | cmdescrita | cmdattrib;

cmdLeitura : 'leia' AP ID FP SC;

cmdescrita : 'escreva' AP ID FP SC;

cmdattrib : ID ATTR expr SC;

expr : termo (OP termo)*;

termo : ID | NUMBER;


AP : '(';

FP : ')';

SC : ';';

OP : '+' | '-' | '*' | '/';

ATTR : '=';

ID : [a-z] ([a-z] | [A-Z] | [0-9])*;