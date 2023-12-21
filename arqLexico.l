%{
	#include <stdio.h>
	int linhas=1;
	int erros=0;
%}

%%

end	{return 0;} /*finaliza o código*/

char|float|int|include|if|else|scan|print|😀 {} /*keywords palavras reservadas*/

["] {}

[0-9]+[_a-zA-Z0-9]* {printf("\n%s invalido na linha %d\n", yytext, linhas); erros++;}
[0-9]+ {} /*tokens validos (strings e numeros)*/
[0-9]+(".")[0-9] {}
[_a-zA-Z][_a-zA-Z0-9]* {}

[\\] {printf("comentarios");}

[ \t] ;  /*separa linhas e espaços*/
[\n] {linhas++;}

"+"|"-"|"*"|"/"|"="|"<"|">"|"=<"|"=>" {} /*tokens reservados para operações*/

","|";"|"_"|"{"|"}"|"("|")"|"." {} /*simbolos especiais reservados*/

. {printf("\n%s invalido na linha %d\n", yytext, linhas); erros++;} /*demais tokens inválidos*/
%%
