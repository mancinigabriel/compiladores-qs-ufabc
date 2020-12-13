package br.com.IsiLanguage.ast;

import java.util.ArrayList;

public class CommandFazer extends AbstractCommand {
 
	private String condition;
	private ArrayList<AbstractCommand> listaCmd;
	
	public CommandFazer(String condition, ArrayList<AbstractCommand> lcmd) {
		this.condition = condition;
		this.listaCmd = lcmd;
	}
	@Override
	public String generateJavaCode() {
		// TODO Auto-generated method stub
		StringBuilder str = new StringBuilder();
		str.append("do{\n");
		for (AbstractCommand cmd: listaCmd) {
			str.append(cmd.generateJavaCode()+"\n");
		}
		str.append("}while("+condition+");");
		return str.toString();
	}
	@Override
	public String toString() {
		return "CommandFazer [condition=[" + condition + "], comandos=" + listaCmd + "]";
	}
	
	

}
