package br.com.IsiLanguage.ast;

import java.util.ArrayList;

public class CommandPara extends AbstractCommand {
 
	private String condition;
	private String inicialization;
	private String incdecr;
	private ArrayList<AbstractCommand> listaCmd;
	
	public CommandPara(String inicialization, String condition, String incdecr, ArrayList<AbstractCommand> lcmd) {
		this.condition = condition;
		this.inicialization = inicialization;
		this.incdecr = incdecr;
		this.listaCmd = lcmd;
	}
	@Override
	public String generateJavaCode() {
		// TODO Auto-generated method stub
		StringBuilder str = new StringBuilder();
		str.append("for (" + inicialization + ";" + condition + ";" + incdecr + ") {\n");
		for (AbstractCommand cmd: listaCmd) {
			str.append(cmd.generateJavaCode()+"\n");
		}
		str.append("}");
		return str.toString();
	}
	@Override
	public String toString() {
		return "CommandPara [inicialization=[" + inicialization + "],condition=[" + condition + "], increment/decrement=[" + incdecr + "], comandos=" + listaCmd + "]";
	}
	
	

}
