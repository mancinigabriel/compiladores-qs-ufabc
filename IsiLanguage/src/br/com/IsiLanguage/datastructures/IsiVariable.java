package br.com.IsiLanguage.datastructures;

public class IsiVariable extends IsiSymbol {
	
	public static final int NUMBER=0;
	public static final int TEXT  =1;
	
	private int type;
	private String value;
	private int att_count;
	private int use_count;
	
	public IsiVariable(String name, int type, String value) {
		super(name);
		this.type = type;
		this.value = value;
		this.att_count = 0;
		this.use_count = 0;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getValue() {
		this.use_count++;		
		return value;
	}

	public void setValue(String value) {
		this.att_count++;
		this.value = value;
	}
	
	public int getAtt_count() {
		return att_count;
	}

	public int getUse_count() {
		return use_count;
	}

	@Override
	public String toString() {
		return "IsiVariable [name=" + name + ", type=" + type + ", value=" + value + "]";
	}
	
	public String generateJavaCode() {
       String str;
       if (type == NUMBER) {
    	   str = "double ";
       }
       else {
    	   str = "String ";
       }
       return str + " "+super.name+";";
	}
	
	

}
