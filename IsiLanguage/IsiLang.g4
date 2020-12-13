grammar IsiLang;

@header{
	import br.com.IsiLanguage.datastructures.IsiSymbol;
	import br.com.IsiLanguage.datastructures.IsiVariable;
	import br.com.IsiLanguage.datastructures.IsiSymbolTable;
	import br.com.IsiLanguage.exceptions.IsiSemanticException;
	import br.com.IsiLanguage.ast.IsiProgram;
	import br.com.IsiLanguage.ast.AbstractCommand;
	import br.com.IsiLanguage.ast.CommandLeitura;
	import br.com.IsiLanguage.ast.CommandEscrita;
	import br.com.IsiLanguage.ast.CommandAtribuicao;
	import br.com.IsiLanguage.ast.CommandDecisao;
	import br.com.IsiLanguage.ast.CommandDecisaoTernario;
	import br.com.IsiLanguage.ast.CommandEnquanto;
	import br.com.IsiLanguage.ast.CommandPara;
	import br.com.IsiLanguage.ast.CommandFazer;
	import java.util.ArrayList;
	import java.util.Stack;
}

@members{
	private int _tipo;
	private String _varName;
	private String _varValue;
	private IsiSymbolTable symbolTable = new IsiSymbolTable();
	private IsiSymbol symbol;
	private IsiProgram program = new IsiProgram();
	private ArrayList<AbstractCommand> curThread;
	private Stack<ArrayList<AbstractCommand>> stack = new Stack<ArrayList<AbstractCommand>>();
	private String _readID;
	private String _writeID;
	private String _exprID;
	private String _exprContent;
	private String _exprDecision;
	private String _exprEnquanto;
	private String _exprParaInit;
	private String _exprParaCond;
	private String _exprParaMuda;
	private String _exprFazer;
	private ArrayList<AbstractCommand> listaTrue;
	private ArrayList<AbstractCommand> listaFalse;
	private ArrayList<AbstractCommand> listaCmd;
	
	public void verificaID(String id){
		if (!symbolTable.exists(id)){
			throw new IsiSemanticException("Symbol "+id+" not declared");
		}
	}
	
	public void exibeComandos(){
		for (AbstractCommand c: program.getComandos()){
			System.out.println(c);
		}
	}
	
	public void generateCode(){
		program.generateTarget();
	}
}
	

prog	: 'programa' decl bloco  'fimprog;'
           {  
           	
           	  program.setVarTable(symbolTable);
           	  program.setComandos(stack.pop());
           	 
           } 
		;
		
decl    :  (declaravar)+
        ;
        
        
declaravar :  tipo ID  {
	                  _varName = _input.LT(-1).getText();
	                  _varValue = null;
	                  symbol = new IsiVariable(_varName, _tipo, _varValue);
	                  if (!symbolTable.exists(_varName)){
	                     symbolTable.add(symbol);	
	                  }
	                  else{
	                  	 throw new IsiSemanticException("Symbol "+_varName+" already declared");
	                  }
                    } 
              (  VIR 
              	 ID {
	                  _varName = _input.LT(-1).getText();
	                  _varValue = null;
	                  symbol = new IsiVariable(_varName, _tipo, _varValue);
	                  if (!symbolTable.exists(_varName)){
	                     symbolTable.add(symbol);	
	                  }
	                  else{
	                  	 throw new IsiSemanticException("Symbol "+_varName+" already declared");
	                  }
                    }
              )* 
               SC
           ;
           
tipo       : 'numero' { _tipo = IsiVariable.NUMBER;  }
           | 'texto'  { _tipo = IsiVariable.TEXT;  }
           ;
        
bloco	: { curThread = new ArrayList<AbstractCommand>(); 
	        stack.push(curThread);  
          }
          (cmd)+
		;
		

cmd		:  cmdleitura  
 		|  cmdescrita 
 		|  cmdattrib
 		|  cmdselecao
		|  cmdselecaoternario
 		|  cmdrepeticao
 		|  cmdrepeticaopara
 		|  cmdrepeticaofazer
		;
		
cmdleitura	: 'leia' AP
                     ID { verificaID(_input.LT(-1).getText());
                     	  _readID = _input.LT(-1).getText();
                        } 
                     FP 
                     SC 
                     
              {
              	IsiVariable var = (IsiVariable)symbolTable.get(_readID);
              	CommandLeitura cmd = new CommandLeitura(_readID, var);
              	stack.peek().add(cmd);
              }   
			;
			
cmdescrita	: 'escreva' 
                 AP 
                 ID { verificaID(_input.LT(-1).getText());
	                  _writeID = _input.LT(-1).getText();
                     } 
                 FP 
                 SC
               {
               	  CommandEscrita cmd = new CommandEscrita(_writeID);
               	  stack.peek().add(cmd);
               }
			;
			
cmdattrib	:  ID { verificaID(_input.LT(-1).getText());
                    _exprID = _input.LT(-1).getText();
                   } 
               ATTR { _exprContent = ""; } 
               expr 
               SC
               {
               	 CommandAtribuicao cmd = new CommandAtribuicao(_exprID, _exprContent);
               	 stack.peek().add(cmd);
               }
			;
			
			
cmdselecao  :  'se' AP
                    ID    { _exprDecision = _input.LT(-1).getText(); }
                    OPREL { _exprDecision += _input.LT(-1).getText(); }
                    (ID | NUMBER) {_exprDecision += _input.LT(-1).getText(); }
                    FP 
                    ACH 
                    { curThread = new ArrayList<AbstractCommand>(); 
                      stack.push(curThread);
                    }
                    (cmd)+ 
                    
                    FCH 
                    {
                       listaTrue = stack.pop();	
                    } 
                   ('senao' 
                   	 ACH
                   	 {
                   	 	curThread = new ArrayList<AbstractCommand>();
                   	 	stack.push(curThread);
                   	 } 
                   	(cmd+) 
                   	FCH
                   	{
                   		listaFalse = stack.pop();
                   		CommandDecisao cmd = new CommandDecisao(_exprDecision, listaTrue, listaFalse);
                   		stack.peek().add(cmd);
                   	}
                   )?
            ;
            
cmdselecaoternario  : (ID | NUMBER) { _exprDecision = _input.LT(-1).getText(); }
                    OPREL { _exprDecision += _input.LT(-1).getText(); }
                    (ID | NUMBER) {_exprDecision += _input.LT(-1).getText(); }
				    'logo'
                    { 
                      curThread = new ArrayList<AbstractCommand>(); 
                      stack.push(curThread);
                    }
                    (cmd)
                    {
                       listaTrue = stack.pop();	
                    } 
                	':' 
                   	 {
                   	 	curThread = new ArrayList<AbstractCommand>();
                   	 	stack.push(curThread);
                   	 } 
                   	(cmd)
                   	{
                   		listaFalse = stack.pop();
                   		CommandDecisaoTernario cmd = new CommandDecisaoTernario(_exprDecision, listaTrue, listaFalse);
                   		stack.peek().add(cmd);
                   	}
            ; 
            
cmdrepeticao	: 'enquanto' AP
							 ID { _exprEnquanto = _input.LT(-1).getText(); }
							 OPREL { _exprEnquanto += _input.LT(-1).getText(); }
							 (ID | NUMBER) {_exprEnquanto += _input.LT(-1).getText();}
							 FP
							 ACH
							 { curThread = new ArrayList<AbstractCommand>(); 
		                      stack.push(curThread);
		                     }
		                     (cmd)+ 
							 FCH{listaCmd = stack.pop();
		                   		 CommandEnquanto cmd = new CommandEnquanto(_exprEnquanto, listaCmd);
		                   		 stack.peek().add(cmd);
                   			 }
                 ;
                 
                 
cmdrepeticaopara	: 'repita' AP 'para' { _exprParaInit = "";} (ID { _exprParaInit += _input.LT(-1).getText();} 
               							 ATTR { _exprParaInit += _input.LT(-1).getText(); } 
               							 (ID | NUMBER) { _exprParaInit += _input.LT(-1).getText();})? 
					  'sendo' (ID | NUMBER) { _exprParaCond = _input.LT(-1).getText(); } 
					  			 OPREL { _exprParaCond += _input.LT(-1).getText(); } 
					  			 (ID | NUMBER) {_exprParaCond += _input.LT(-1).getText(); }
					  'passo'  (ID { _exprParaMuda = _input.LT(-1).getText();}
					  			  ATTR { _exprParaMuda += _input.LT(-1).getText(); }
					  			  ID { _exprParaMuda += _input.LT(-1).getText();} 
               					  OP { _exprParaMuda += _input.LT(-1).getText(); } 
               					 (ID | NUMBER) { _exprParaMuda += _input.LT(-1).getText();})? 
					  		  FP
							 ACH
							 { curThread = new ArrayList<AbstractCommand>(); 
		                      stack.push(curThread);
		                     }
		                     (cmd)+ 
							 FCH
							 {
							 	 listaCmd = stack.pop();
		                   		 CommandPara cmd = new CommandPara(_exprParaInit, _exprParaCond, _exprParaMuda, listaCmd);
		                   		 stack.peek().add(cmd);
                   			 }
                 ;
                 
                 
cmdrepeticaofazer	: 'execute' 
							 ACH
							 { curThread = new ArrayList<AbstractCommand>(); 
		                      stack.push(curThread);
		                     }
		                     (cmd)+ 
							 FCH
					  'ate' 
							  AP
					  			(ID | NUMBER) { _exprFazer = _input.LT(-1).getText(); } 
					  			 OPREL { _exprFazer += _input.LT(-1).getText(); } 
					  			(ID | NUMBER) { _exprFazer += _input.LT(-1).getText(); }
							  FP
							  SC
							 {
							 	 listaCmd = stack.pop();
		                   		 CommandFazer cmd = new CommandFazer(_exprFazer, listaCmd);
		                   		 stack.peek().add(cmd);
                   			 }
                 ;
                 
			
expr		:  termo ( 
	             OP  { _exprContent += _input.LT(-1).getText();}
	            termo
	            )*
			;
			
termo		: ID { verificaID(_input.LT(-1).getText());
	               _exprContent += _input.LT(-1).getText();
                 } 
            | 
              NUMBER
              {
              	_exprContent += _input.LT(-1).getText();
              }
			;
			
COMMENT
    : '<*' .*? '*>'  {
                   		 System.out.println("Comentário de bloco identificado, não será transpilado!");
           			 }
     -> skip
    ;
    
LINECOMMENT
    : '#' ~[\r\n]*  {
                   		 System.out.println("Comentário de linha identificado, não será transpilado!");
           			 }
     -> skip
    ;

AP	: '('
	;
	
FP	: ')'
	;
	
SC	: ';'
	;
	
OP	: '+' | '-' | '*' | '/'
	;
	
ATTR : '='
	 ;
	 
VIR  : ','
     ;
     
ACH  : '{'
     ;
     
FCH  : '}'
     ;
	 
	 
OPREL : '>' | '<' | '>=' | '<=' | '==' | '!='
      ;
      
ID	: [a-z] ([a-z] | [A-Z] | [0-9])*
	;
	
NUMBER	: [0-9]+ ('.' [0-9]+)?
		;
		
WS	: (' ' | '\t' | '\n' | '\r') -> skip;