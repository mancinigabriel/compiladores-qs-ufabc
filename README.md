# compiladores-qs-ufabc
Repositório para o projeto da disciplina de Compiladores do BCC na UFABC.

O objetivo deste trabalho é desenvolver os aspectos práticos da
IsiLanguage. Uma linguagem de programação imperativa muito
próxima do Português estruturado.

- Instruções:
	
	- A pasta IsiLanguage é onde está o início do projeto;
		- É um projeto que eu iniciei em Java;
	- Pessoal, já deixei o PDF do enunciado do projeto aqui no rep (vai contra as práticas, mas quero facilitar pra gente);
	- Também deixei o .jar do ANTLR no rep pra facilitar pra gente;
	- A partir da aula 7 é que o professor começa a usar o ANTLR:
		- Link aula 7: https://www.youtube.com/watch?v=_r3fT7oFNxw&ab_channel=ProfessorIsidro
		- O professor começa a configurar o ANTLR junto ao Eclipse no minuto 17:00 até o minuto 18:00;
		- Não é nada muito complexo, já deixei o arquivo no jeito pra encontrar;
		- Na live o professor vai esquecer de compartilhar os passos, mas vocês podem seguir o áudio que vai dar certo (posso ajudar, se precisar);
	- Importante: https://drive.google.com/drive/folders/1dVOxOzCX1jiRDrsDS9F-lkYgbvO2LSlz?usp=sharing
		- Nesse link do drive que coloquei acima, coloquei a última versão do Eclipse e do JDK que são necessários para instalação do JAVA (Windows);
		- Também coloquei os arquivos que mencionei nos tópicos acima;
	- Importante II: pessoal para ter aquele debugger do ANTLR4 que vai testando a análise sintátiva e léxica durante a edição você precisam
		- Vá no menu Help depois em Eclipse Marketplace, daí pesquise pelo plugin ANTLR 4 IDE 0.3.6;
		- Intala ele e reinicia o eclipse, daí o código do arquivo IsiLang.g4 vai ser interpretado em tempo real; 

- Pontos importantes que devemos fazer na linguagem do projeto:
	- A linguagem do projeto tem recursividade à esquerda, precisamos eliminar isso (Aula 7 - minuto 21:00);
	- Ela pode ter necessidade de fatoração à esquerda;
	- Em suma, ela não está LL1, temos que colocá-la em LL1;

- Tutorias (a documentação já é bem sussa):
	- https://tomassetti.me/antlr-mega-tutorial/
	- https://pragprog.com/titles/tpantlr2/the-definitive-antlr-4-reference/
	- https://github.com/antlr/antlr4/blob/master/doc/index.md
	- https://vepo.medium.com/como-criar-uma-linguagem-usando-antlr4-e-java-ad834fadc2c1

- ANTLR Anotações:
	- Todas as regras sintáticas devem começar em letras minúsculas;
	- Todas as regras léxicas devem começar em letras maiúsculas;
