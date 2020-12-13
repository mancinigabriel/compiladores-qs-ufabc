// Generated from IsiLang.g4 by ANTLR 4.7.1
package br.com.IsiLanguage.parser;

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

import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.misc.*;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class IsiLangLexer extends Lexer {
	static { RuntimeMetaData.checkVersion("4.7.1", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, T__7=8, T__8=9, 
		T__9=10, T__10=11, T__11=12, T__12=13, T__13=14, T__14=15, T__15=16, T__16=17, 
		COMMENT=18, LINECOMMENT=19, AP=20, FP=21, SC=22, OP=23, ATTR=24, VIR=25, 
		ACH=26, FCH=27, OPREL=28, ID=29, NUMBER=30, TEXT=31, WS=32;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	public static final String[] ruleNames = {
		"T__0", "T__1", "T__2", "T__3", "T__4", "T__5", "T__6", "T__7", "T__8", 
		"T__9", "T__10", "T__11", "T__12", "T__13", "T__14", "T__15", "T__16", 
		"COMMENT", "LINECOMMENT", "AP", "FP", "SC", "OP", "ATTR", "VIR", "ACH", 
		"FCH", "OPREL", "ID", "NUMBER", "TEXT", "WS"
	};

	private static final String[] _LITERAL_NAMES = {
		null, "'programa'", "'fimprog;'", "'numero'", "'texto'", "'leia'", "'escreva'", 
		"'se'", "'senao'", "'logo'", "':'", "'enquanto'", "'repita'", "'para'", 
		"'sendo'", "'passo'", "'execute'", "'ate'", null, null, "'('", "')'", 
		"';'", null, "'='", "','", "'{'", "'}'"
	};
	private static final String[] _SYMBOLIC_NAMES = {
		null, null, null, null, null, null, null, null, null, null, null, null, 
		null, null, null, null, null, null, "COMMENT", "LINECOMMENT", "AP", "FP", 
		"SC", "OP", "ATTR", "VIR", "ACH", "FCH", "OPREL", "ID", "NUMBER", "TEXT", 
		"WS"
	};
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}


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


	public IsiLangLexer(CharStream input) {
		super(input);
		_interp = new LexerATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@Override
	public String getGrammarFileName() { return "IsiLang.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public String[] getChannelNames() { return channelNames; }

	@Override
	public String[] getModeNames() { return modeNames; }

	@Override
	public ATN getATN() { return _ATN; }

	@Override
	public void action(RuleContext _localctx, int ruleIndex, int actionIndex) {
		switch (ruleIndex) {
		case 17:
			COMMENT_action((RuleContext)_localctx, actionIndex);
			break;
		case 18:
			LINECOMMENT_action((RuleContext)_localctx, actionIndex);
			break;
		}
	}
	private void COMMENT_action(RuleContext _localctx, int actionIndex) {
		switch (actionIndex) {
		case 0:

			                   		 System.out.println("Comentário de bloco identificado, não será transpilado!");
			           			 
			break;
		}
	}
	private void LINECOMMENT_action(RuleContext _localctx, int actionIndex) {
		switch (actionIndex) {
		case 1:

			                   		 System.out.println("Comentário de linha identificado, não será transpilado!");
			           			 
			break;
		}
	}

	public static final String _serializedATN =
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\"\u0103\b\1\4\2\t"+
		"\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13"+
		"\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22"+
		"\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31\t\31"+
		"\4\32\t\32\4\33\t\33\4\34\t\34\4\35\t\35\4\36\t\36\4\37\t\37\4 \t \4!"+
		"\t!\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\2\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3"+
		"\3\3\3\3\4\3\4\3\4\3\4\3\4\3\4\3\4\3\5\3\5\3\5\3\5\3\5\3\5\3\6\3\6\3\6"+
		"\3\6\3\6\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\b\3\b\3\b\3\t\3\t\3\t\3\t\3"+
		"\t\3\t\3\n\3\n\3\n\3\n\3\n\3\13\3\13\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3"+
		"\f\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\16\3\16\3\16\3\16\3\16\3\17\3\17\3\17"+
		"\3\17\3\17\3\17\3\20\3\20\3\20\3\20\3\20\3\20\3\21\3\21\3\21\3\21\3\21"+
		"\3\21\3\21\3\21\3\22\3\22\3\22\3\22\3\23\3\23\3\23\3\23\7\23\u00b1\n\23"+
		"\f\23\16\23\u00b4\13\23\3\23\3\23\3\23\3\23\3\23\3\23\3\23\3\24\3\24\7"+
		"\24\u00bf\n\24\f\24\16\24\u00c2\13\24\3\24\3\24\3\24\3\24\3\25\3\25\3"+
		"\26\3\26\3\27\3\27\3\30\3\30\3\31\3\31\3\32\3\32\3\33\3\33\3\34\3\34\3"+
		"\35\3\35\3\35\3\35\3\35\3\35\3\35\3\35\3\35\5\35\u00e1\n\35\3\36\3\36"+
		"\7\36\u00e5\n\36\f\36\16\36\u00e8\13\36\3\37\6\37\u00eb\n\37\r\37\16\37"+
		"\u00ec\3\37\3\37\6\37\u00f1\n\37\r\37\16\37\u00f2\5\37\u00f5\n\37\3 \3"+
		" \7 \u00f9\n \f \16 \u00fc\13 \3 \3 \3!\3!\3!\3!\4\u00b2\u00fa\2\"\3\3"+
		"\5\4\7\5\t\6\13\7\r\b\17\t\21\n\23\13\25\f\27\r\31\16\33\17\35\20\37\21"+
		"!\22#\23%\24\'\25)\26+\27-\30/\31\61\32\63\33\65\34\67\359\36;\37= ?!"+
		"A\"\3\2\t\4\2\f\f\17\17\5\2,-//\61\61\4\2>>@@\3\2c|\5\2\62;C\\c|\3\2\62"+
		";\5\2\13\f\17\17\"\"\2\u010d\2\3\3\2\2\2\2\5\3\2\2\2\2\7\3\2\2\2\2\t\3"+
		"\2\2\2\2\13\3\2\2\2\2\r\3\2\2\2\2\17\3\2\2\2\2\21\3\2\2\2\2\23\3\2\2\2"+
		"\2\25\3\2\2\2\2\27\3\2\2\2\2\31\3\2\2\2\2\33\3\2\2\2\2\35\3\2\2\2\2\37"+
		"\3\2\2\2\2!\3\2\2\2\2#\3\2\2\2\2%\3\2\2\2\2\'\3\2\2\2\2)\3\2\2\2\2+\3"+
		"\2\2\2\2-\3\2\2\2\2/\3\2\2\2\2\61\3\2\2\2\2\63\3\2\2\2\2\65\3\2\2\2\2"+
		"\67\3\2\2\2\29\3\2\2\2\2;\3\2\2\2\2=\3\2\2\2\2?\3\2\2\2\2A\3\2\2\2\3C"+
		"\3\2\2\2\5L\3\2\2\2\7U\3\2\2\2\t\\\3\2\2\2\13b\3\2\2\2\rg\3\2\2\2\17o"+
		"\3\2\2\2\21r\3\2\2\2\23x\3\2\2\2\25}\3\2\2\2\27\177\3\2\2\2\31\u0088\3"+
		"\2\2\2\33\u008f\3\2\2\2\35\u0094\3\2\2\2\37\u009a\3\2\2\2!\u00a0\3\2\2"+
		"\2#\u00a8\3\2\2\2%\u00ac\3\2\2\2\'\u00bc\3\2\2\2)\u00c7\3\2\2\2+\u00c9"+
		"\3\2\2\2-\u00cb\3\2\2\2/\u00cd\3\2\2\2\61\u00cf\3\2\2\2\63\u00d1\3\2\2"+
		"\2\65\u00d3\3\2\2\2\67\u00d5\3\2\2\29\u00e0\3\2\2\2;\u00e2\3\2\2\2=\u00ea"+
		"\3\2\2\2?\u00f6\3\2\2\2A\u00ff\3\2\2\2CD\7r\2\2DE\7t\2\2EF\7q\2\2FG\7"+
		"i\2\2GH\7t\2\2HI\7c\2\2IJ\7o\2\2JK\7c\2\2K\4\3\2\2\2LM\7h\2\2MN\7k\2\2"+
		"NO\7o\2\2OP\7r\2\2PQ\7t\2\2QR\7q\2\2RS\7i\2\2ST\7=\2\2T\6\3\2\2\2UV\7"+
		"p\2\2VW\7w\2\2WX\7o\2\2XY\7g\2\2YZ\7t\2\2Z[\7q\2\2[\b\3\2\2\2\\]\7v\2"+
		"\2]^\7g\2\2^_\7z\2\2_`\7v\2\2`a\7q\2\2a\n\3\2\2\2bc\7n\2\2cd\7g\2\2de"+
		"\7k\2\2ef\7c\2\2f\f\3\2\2\2gh\7g\2\2hi\7u\2\2ij\7e\2\2jk\7t\2\2kl\7g\2"+
		"\2lm\7x\2\2mn\7c\2\2n\16\3\2\2\2op\7u\2\2pq\7g\2\2q\20\3\2\2\2rs\7u\2"+
		"\2st\7g\2\2tu\7p\2\2uv\7c\2\2vw\7q\2\2w\22\3\2\2\2xy\7n\2\2yz\7q\2\2z"+
		"{\7i\2\2{|\7q\2\2|\24\3\2\2\2}~\7<\2\2~\26\3\2\2\2\177\u0080\7g\2\2\u0080"+
		"\u0081\7p\2\2\u0081\u0082\7s\2\2\u0082\u0083\7w\2\2\u0083\u0084\7c\2\2"+
		"\u0084\u0085\7p\2\2\u0085\u0086\7v\2\2\u0086\u0087\7q\2\2\u0087\30\3\2"+
		"\2\2\u0088\u0089\7t\2\2\u0089\u008a\7g\2\2\u008a\u008b\7r\2\2\u008b\u008c"+
		"\7k\2\2\u008c\u008d\7v\2\2\u008d\u008e\7c\2\2\u008e\32\3\2\2\2\u008f\u0090"+
		"\7r\2\2\u0090\u0091\7c\2\2\u0091\u0092\7t\2\2\u0092\u0093\7c\2\2\u0093"+
		"\34\3\2\2\2\u0094\u0095\7u\2\2\u0095\u0096\7g\2\2\u0096\u0097\7p\2\2\u0097"+
		"\u0098\7f\2\2\u0098\u0099\7q\2\2\u0099\36\3\2\2\2\u009a\u009b\7r\2\2\u009b"+
		"\u009c\7c\2\2\u009c\u009d\7u\2\2\u009d\u009e\7u\2\2\u009e\u009f\7q\2\2"+
		"\u009f \3\2\2\2\u00a0\u00a1\7g\2\2\u00a1\u00a2\7z\2\2\u00a2\u00a3\7g\2"+
		"\2\u00a3\u00a4\7e\2\2\u00a4\u00a5\7w\2\2\u00a5\u00a6\7v\2\2\u00a6\u00a7"+
		"\7g\2\2\u00a7\"\3\2\2\2\u00a8\u00a9\7c\2\2\u00a9\u00aa\7v\2\2\u00aa\u00ab"+
		"\7g\2\2\u00ab$\3\2\2\2\u00ac\u00ad\7>\2\2\u00ad\u00ae\7,\2\2\u00ae\u00b2"+
		"\3\2\2\2\u00af\u00b1\13\2\2\2\u00b0\u00af\3\2\2\2\u00b1\u00b4\3\2\2\2"+
		"\u00b2\u00b3\3\2\2\2\u00b2\u00b0\3\2\2\2\u00b3\u00b5\3\2\2\2\u00b4\u00b2"+
		"\3\2\2\2\u00b5\u00b6\7,\2\2\u00b6\u00b7\7@\2\2\u00b7\u00b8\3\2\2\2\u00b8"+
		"\u00b9\b\23\2\2\u00b9\u00ba\3\2\2\2\u00ba\u00bb\b\23\3\2\u00bb&\3\2\2"+
		"\2\u00bc\u00c0\7%\2\2\u00bd\u00bf\n\2\2\2\u00be\u00bd\3\2\2\2\u00bf\u00c2"+
		"\3\2\2\2\u00c0\u00be\3\2\2\2\u00c0\u00c1\3\2\2\2\u00c1\u00c3\3\2\2\2\u00c2"+
		"\u00c0\3\2\2\2\u00c3\u00c4\b\24\4\2\u00c4\u00c5\3\2\2\2\u00c5\u00c6\b"+
		"\24\3\2\u00c6(\3\2\2\2\u00c7\u00c8\7*\2\2\u00c8*\3\2\2\2\u00c9\u00ca\7"+
		"+\2\2\u00ca,\3\2\2\2\u00cb\u00cc\7=\2\2\u00cc.\3\2\2\2\u00cd\u00ce\t\3"+
		"\2\2\u00ce\60\3\2\2\2\u00cf\u00d0\7?\2\2\u00d0\62\3\2\2\2\u00d1\u00d2"+
		"\7.\2\2\u00d2\64\3\2\2\2\u00d3\u00d4\7}\2\2\u00d4\66\3\2\2\2\u00d5\u00d6"+
		"\7\177\2\2\u00d68\3\2\2\2\u00d7\u00e1\t\4\2\2\u00d8\u00d9\7@\2\2\u00d9"+
		"\u00e1\7?\2\2\u00da\u00db\7>\2\2\u00db\u00e1\7?\2\2\u00dc\u00dd\7?\2\2"+
		"\u00dd\u00e1\7?\2\2\u00de\u00df\7#\2\2\u00df\u00e1\7?\2\2\u00e0\u00d7"+
		"\3\2\2\2\u00e0\u00d8\3\2\2\2\u00e0\u00da\3\2\2\2\u00e0\u00dc\3\2\2\2\u00e0"+
		"\u00de\3\2\2\2\u00e1:\3\2\2\2\u00e2\u00e6\t\5\2\2\u00e3\u00e5\t\6\2\2"+
		"\u00e4\u00e3\3\2\2\2\u00e5\u00e8\3\2\2\2\u00e6\u00e4\3\2\2\2\u00e6\u00e7"+
		"\3\2\2\2\u00e7<\3\2\2\2\u00e8\u00e6\3\2\2\2\u00e9\u00eb\t\7\2\2\u00ea"+
		"\u00e9\3\2\2\2\u00eb\u00ec\3\2\2\2\u00ec\u00ea\3\2\2\2\u00ec\u00ed\3\2"+
		"\2\2\u00ed\u00f4\3\2\2\2\u00ee\u00f0\7\60\2\2\u00ef\u00f1\t\7\2\2\u00f0"+
		"\u00ef\3\2\2\2\u00f1\u00f2\3\2\2\2\u00f2\u00f0\3\2\2\2\u00f2\u00f3\3\2"+
		"\2\2\u00f3\u00f5\3\2\2\2\u00f4\u00ee\3\2\2\2\u00f4\u00f5\3\2\2\2\u00f5"+
		">\3\2\2\2\u00f6\u00fa\7)\2\2\u00f7\u00f9\13\2\2\2\u00f8\u00f7\3\2\2\2"+
		"\u00f9\u00fc\3\2\2\2\u00fa\u00fb\3\2\2\2\u00fa\u00f8\3\2\2\2\u00fb\u00fd"+
		"\3\2\2\2\u00fc\u00fa\3\2\2\2\u00fd\u00fe\7)\2\2\u00fe@\3\2\2\2\u00ff\u0100"+
		"\t\b\2\2\u0100\u0101\3\2\2\2\u0101\u0102\b!\3\2\u0102B\3\2\2\2\f\2\u00b2"+
		"\u00c0\u00e0\u00e4\u00e6\u00ec\u00f2\u00f4\u00fa\5\3\23\2\b\2\2\3\24\3";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}