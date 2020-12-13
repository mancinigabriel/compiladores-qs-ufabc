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
	
	public IsiSymbol getSymbolByID(String id){
		return symbolTable.get(id);
	}	
	
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
	
	public void verifyVariables(){
		program.verifyTable();
	}
	
	public void generateCode(){
		program.generateTarget();
	}
}
	

prog	: 'programa' decl bloco  'fimprog;'
           {  
           	
           	  program.setVarTable(symbolTable);
           	  program.setComandos(stack.pop());
           	  verifyVariables();           	  
           	 
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
              	IsiSymbol symbolLeitura = getSymbolByID(_readID);
               	IsiVariable variableLeitura = (IsiVariable)symbolLeitura;
               	variableLeitura.setValue("x");              	
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
	              	IsiSymbol symbolEscrita = getSymbolByID(_writeID);
	               	IsiVariable variableEscrita = (IsiVariable)symbolEscrita;
	               	String x = variableEscrita.getValue();                   	  
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
                 IsiSymbol symbolAtt = getSymbolByID(_exprID);
               	 IsiVariable variableAtt = (IsiVariable)symbolAtt;
               	 variableAtt.setValue(_exprContent);
               	 stack.peek().add(cmd);
               }
			;
			
			
cmdselecao  :  'se' AP
                    ID    { _exprDecision = _input.LT(-1).getText();
                    		IsiSymbol symbol = getSymbolByID(_exprDecision);
	               			IsiVariable variable = (IsiVariable)symbol;
	               			String s = variable.getValue();     }
                    OPREL { _exprDecision += _input.LT(-1).getText(); }
                    (ID | NUMBER) {String var = _input.LT(-1).getText();
                   				  	_exprDecision += var;
                   				  	if(symbolTable.exists(var)){
	                   					IsiSymbol symbolSelecao = getSymbolByID(var);
		               					IsiVariable variableSelecao = (IsiVariable)symbolSelecao;
		               					String w = variableSelecao.getValue();
		               				}   
                   				  	
                      }
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
            
cmdselecaoternario  : (ID | NUMBER) { String var = _input.LT(-1).getText();
						_exprDecision = var;
       				  	if(symbolTable.exists(var)){
           					IsiSymbol symbol = getSymbolByID(var);
           					IsiVariable variable = (IsiVariable)symbol;
           					String w = variable.getValue();
           				}   						
					}
                    OPREL { _exprDecision += _input.LT(-1).getText(); }
                    (ID | NUMBER) {String var2 = _input.LT(-1).getText();
                   				  	_exprDecision += var2;
                   				  	if(symbolTable.exists(var2)){
	                   					IsiSymbol symbolTernario = getSymbolByID(var2);
		               					IsiVariable variableTernario = (IsiVariable)symbolTernario;
		               					String t = variableTernario.getValue();
		               				}   
                   				  	
                      }
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
							 ID { _exprEnquanto = _input.LT(-1).getText();
									IsiSymbol symbol = getSymbolByID(_exprEnquanto);
			               			IsiVariable variable = (IsiVariable)symbol;
			               			String x = variable.getValue();     }
							 OPREL { _exprEnquanto += _input.LT(-1).getText(); }
							 (ID | NUMBER) { String var = _input.LT(-1).getText();
                   				  	_exprEnquanto += var;
                   				  	if(symbolTable.exists(var)){
	                   					IsiSymbol symbolEnquanto = getSymbolByID(var);
		               					IsiVariable variableEnquanto = (IsiVariable)symbolEnquanto;
		               					String y = variableEnquanto.getValue();
		               				} 
		               			}
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
                 
                 
cmdrepeticaopara	: 'repita' AP 'para' { _exprParaInit = "";} 

						(ID { String var = _input.LT(-1).getText();
								_exprParaInit += var;
               				  	if(symbolTable.exists(var)){
                   					IsiSymbol symbol = getSymbolByID(var);
	               					IsiVariable variable = (IsiVariable)symbol;
	               					String x = variable.getValue();
	               				}								
							} 
						
               			ATTR { _exprParaInit += _input.LT(-1).getText(); } 
               			(ID | NUMBER) { 
               				String var2 = _input.LT(-1).getText();
               				_exprParaInit += var2;
           				  	if(symbolTable.exists(var2)){
               					IsiSymbol symbol2 = getSymbolByID(var2);
               					IsiVariable variable2 = (IsiVariable)symbol2;
               					String y = variable2.getValue();
               				}	               				
               			
               			
               			})? 
						
					  'sendo' (ID | NUMBER) {
					  		 	_exprParaCond = _input.LT(-1).getText(); 
           				  		if(symbolTable.exists(_exprParaCond)){
               						IsiSymbol symbolSendo = getSymbolByID(_exprParaCond);
               						IsiVariable variableSendo = (IsiVariable)symbolSendo;
               						String z = variableSendo.getValue();
               					}					  
					  
					  		} 
					  			 OPREL { _exprParaCond += _input.LT(-1).getText(); } 
					  			 (ID | NUMBER) {
					  			 	String expParaCond = _input.LT(-1).getText(); 	
					  			 	_exprParaCond += expParaCond;
	           				  		if(symbolTable.exists(expParaCond)){
	               						IsiSymbol symbolSendoCond = getSymbolByID(expParaCond);
	               						IsiVariable variableSendoCond = (IsiVariable)symbolSendoCond;
	               						String c = variableSendoCond.getValue();
	               					}						  			 	
					  			 }
					  'passo'  (ID {
					  				 _exprParaMuda = _input.LT(-1).getText();
	           				  		if(symbolTable.exists(_exprParaMuda)){
	               						IsiSymbol symbolParaMuda = getSymbolByID(_exprParaMuda);
	               						IsiVariable variableParaMuda = (IsiVariable)symbolParaMuda;
	               						String pm = variableParaMuda.getValue();
	               					}						  				 
					  				
					  			}
					  			  ATTR { _exprParaMuda += _input.LT(-1).getText(); }
					  			  ID {  String varPM = _input.LT(-1).getText();
					  			  		_exprParaMuda += varPM;
		           				  		if(symbolTable.exists(varPM)){
		               						IsiSymbol symbolPM = getSymbolByID(varPM);
		               						IsiVariable variablePM = (IsiVariable)symbolPM;
		               						String pm = variablePM.getValue();
		               					}						  			  		
					  			  	} 
               					  OP { _exprParaMuda += _input.LT(-1).getText(); } 
               					 (ID | NUMBER) { 
               					 		String var = _input.LT(-1).getText();
               					 		_exprParaMuda += var;
		           				  		if(symbolTable.exists(var)){
		               						IsiSymbol symbolPM = getSymbolByID(var);
		               						IsiVariable variablePM = (IsiVariable)symbolPM;
		               						String pm = variablePM.getValue();
		               					}	               					 		
               					 		
               					 		})? 
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
					  			(ID | NUMBER) { 
					  					_exprFazer = _input.LT(-1).getText(); 
	                   				  	if(symbolTable.exists(_exprFazer)){
		                   					IsiSymbol symbol = getSymbolByID(_exprFazer);
			               					IsiVariable variable = (IsiVariable)symbol;
			               					String x = variable.getValue();
			               				}  					  				
					  				} 
					  			 OPREL { _exprFazer += _input.LT(-1).getText(); } 
					  			(ID | NUMBER) { 
					  					String var = _input.LT(-1).getText(); 
					  					_exprFazer += var;
	                   				  	if(symbolTable.exists(var)){
		                   					IsiSymbol symbol = getSymbolByID(var);
			               					IsiVariable variable = (IsiVariable)symbol;
			               					String x = variable.getValue();
			               				}					  					
					  					
					  					}
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
					String var = _input.LT(-1).getText();
	               _exprContent += var;
	               	IsiSymbol symbol = getSymbolByID(var);
		    		IsiVariable variable = (IsiVariable)symbol;
		            String x = variable.getValue();
	               
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