package br.com.IsiLanguage.ast;

import java.util.ArrayList;

public class CommandEnquanto extends AbstractCommand {
 
	private String condition;
	private ArrayList<AbstractCommand> listaCmd;
	
	public CommandEnquanto(String condition, ArrayList<AbstractCommand> lcmd) {
		this.condition = condition;
		this.listaCmd = lcmd;
	}
	@Override
	public String generateJavaCode() {
		// TODO Auto-generated method stub
		StringBuilder str = new StringBuilder();
		str.append("while ("+condition+") {\n");
		for (AbstractCommand cmd: listaCmd) {
			str.append(cmd.generateJavaCode());
		}
		str.append("}");
		return str.toString();
	}
	@Override
	public String toString() {
		return "CommandEnquanto [condition=" + condition + ", comandos=" + listaCmd + "]";
	}
	
	

}
