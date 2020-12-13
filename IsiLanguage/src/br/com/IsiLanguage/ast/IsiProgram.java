package br.com.IsiLanguage.ast;

import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;

import br.com.IsiLanguage.datastructures.IsiSymbol;
import br.com.IsiLanguage.datastructures.IsiSymbolTable;
import br.com.IsiLanguage.datastructures.IsiVariable;
import br.com.IsiLanguage.exceptions.IsiSemanticException;

public class IsiProgram {
	private IsiSymbolTable varTable;
	private ArrayList<AbstractCommand> comandos;
	private String programName;

	public void generateTarget() {
		StringBuilder str = new StringBuilder();
		str.append("import java.util.Scanner;\n");
		str.append("public class MainClass{ \n");
		str.append("  public static void main(String args[]){\n ");
		str.append("      Scanner _key = new Scanner(System.in);\n");
		for (IsiSymbol symbol: varTable.getAll()) {
			str.append(symbol.generateJavaCode()+"\n");
		}
		for (AbstractCommand command: comandos) {
			str.append(command.generateJavaCode()+"\n");
		}
		str.append("  }");
		str.append("}");
		
		try {
			FileWriter fr = new FileWriter(new File("MainClass.java"));
			fr.write(str.toString());
			fr.close();
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}

	}

	public IsiSymbolTable getVarTable() {
		return varTable;
	}

	public void setVarTable(IsiSymbolTable varTable) {
		this.varTable = varTable;
	}

	public ArrayList<AbstractCommand> getComandos() {
		return comandos;
	}

	public void setComandos(ArrayList<AbstractCommand> comandos) {
		this.comandos = comandos;
	}

	public String getProgramName() {
		return programName;
	}

	public void setProgramName(String programName) {
		this.programName = programName;
	}
	
	public void verifyTable() {
		for (IsiSymbol symbol : this.varTable.getAll()) {
				IsiVariable var = (IsiVariable)symbol;
				
				if(var.getAtt_count() == 0) {
					throw new IsiSemanticException("Variable "+var.getName()+" has not been assigned.");
				}
				
				if(var.getUse_count() == 0) {
					throw new IsiSemanticException("Variable "+var.getName()+" is not used");
				}
			}

		}

}
