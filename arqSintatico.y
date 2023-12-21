%{
	#include "cabecalho.h"
	#include <string.h>
	#include <stdio.h>
	#include <stdlib.h>
	extern int linhas;
	extern int erros;
%}

%token ASPAS ABRE_PARENTESIS FECHA_PARENTESIS ABRE_CHAVE FECHA_CHAVE SEPARADOR VIRGULA FLOAT INT PRINTF VOID DOUBLE LONG MAIN IDENTIFICADOR INTEIRO REAL OPERADOR COMPARADORES NEGACAO IGUAL ATRIBUICAO 
%start Programa_principal

%%

y: IDENTIFICADOR y | ;

Qualquer_palavra: IDENTIFICADOR y;

Print: PRINTF ABRE_PARENTESIS ASPAS Qualquer_palavra ASPAS FECHA_PARENTESIS SEPARADOR;

x: OPERADOR Exp | ;

Exp: INT x | FLOAT x | Num x | IDENTIFICADOR x;

Atribuicao: IDENTIFICADOR IGUAL Exp SEPARADOR ;

Num: INTEIRO | REAL ;

LISTA_VAR: IDENTIFICADOR Atribuicao VIRGULA LISTA_VAR | IDENTIFICADOR Atribuicao;

Decl: LISTA_VAR ;

Tipo: INT | FLOAT | DOUBLE | LONG INT ;

Declaracao: Tipo Decl SEPARADOR;

Comando: Declaracao | Atribuicao | Print | error {yyerror("", linhas); };

Comandos: Comando Comandos | Comando | ;

Programa_principal: MAIN ABRE_PARENTESIS FECHA_PARENTESIS ABRE_CHAVE Comandos FECHA_CHAVE | error {yyerror("", linhas); };

%%

int yyerror(char *str, int num_linha) {
	if(strcmp(str,"syntax error")==0) {
		erros++;
		printf("\nErro sintático");//Exibe mensagem de erro
	}
	else
		printf("\nO erro aparece próximo à linha %d\n", num_linha);
	
	return erros;
}


main (int argc, char **argv ) {
	FILE *yyin;
	++argv, --argc; //desconsidera o nome do programa
	
		yyin = fopen( argv[0], "r" );

	do {
		yyparse();
	} while (!feof(yyin));
	
	if(erros==0)
		puts("Análise concluída com sucesso");
	
	fclose(yyin);
}
