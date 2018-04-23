%{

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "y.tab.h"

//Declaração de variáveis
char nova_str[200];
void yyerror(char *);
char entrada[200], saida[200];
int tam_str;
int k; //indice da saida

//Funções
void retirar_maiorque_e_menorque(char *entrada, char *saida, int numeroDeTags){
	//Declaração de variáveis
	int tam_str, k, tagsEncontradas;

	//Limpando a saida
	for (int j=0; j<200; j++){
		saida[j] = '\0';
	}

	//Inicializando as variáveis
	tagsEncontradas = 0;
	tam_str = strlen(entrada);

	//Varre a entrada
	for (int i=0; i<tam_str; i++){
		//Se encontra o fim de uma tag
		if (entrada[i] == '>'){
			tagsEncontradas++;
			//Se já abriu tags o suficiente pra pegar o conteúdo
			if(tagsEncontradas == numeroDeTags){
				i++;
				k = 0;
				//Copia o conteúdo até achar a abertura da tag de fechar
				while (entrada[i] != '<'){
					saida[k] = entrada[i];
					i++;
					k++;
				}
				break;
			}
		}
	}
	return;
}

void converteCodigoEmMunicipio(char *codigo, char *palavra) {
	if(strcmp(codigo, "1502152") == 0){
	  strcpy(palavra, "CANAA DOS CARAJAS");
	}
	else if(strcmp(codigo, "1504208") == 0){
	  strcpy(palavra, "MARABA");
	}
	else if(strcmp(codigo, "1505437") == 0){
	  strcpy(palavra, "OURILANDIA DO NORTE");
	}
	else if(strcmp(codigo, "1505536") == 0){
	  strcpy(palavra, "PARAUAPEBAS");
	}
	else if(strcmp(codigo, "2111300") == 0){
	  strcpy(palavra, "SÃO LUIS");
	}
	else if(strcmp(codigo, "3106200") == 0){
	  strcpy(palavra, "BELO HORIZONTE");
	}
	else if(strcmp(codigo, "3127701") == 0){
		strcpy(palavra, "GOVERNADOR VALADARES");
	}
	else if(strcmp(codigo, "3131703") == 0){
	  strcpy(palavra, "ITABIRA");
	}
	else if(strcmp(codigo, "3136207") == 0) {
		strcpy(palavra, "JOAO MONLEVADE");
	}
	else if(strcmp(codigo, "3144805") == 0){
	  strcpy(palavra, "NOVA LIMA");
	}
	else if(strcmp(codigo, "3205309") == 0){
	  strcpy(palavra, "VITORIA");
	}
	else if(strcmp(codigo, "3302007") == 0) {
		strcpy(palavra, "ITAGUAI");
	}
	else if(strcmp(codigo, "3304557") == 0){
	  strcpy(palavra, "RIO DE JANEIRO");
	}
	else if(strcmp(codigo, "5003207") == 0){
	  strcpy(palavra, "CORUMBA");
	}



}

%}

PALAVRA [a-zA-Z\ ]+
NUMERO [0-9]+[,]*[.]*[0-9]*
EMAIL [a-zA-Z0-9.]*@[a-zA-Z0-9.]*

%%

(<TOMADOR_CIDADE>{PALAVRA}<\/TOMADOR_CIDADE>) { //BELÉM
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	yylval.string=strdup(nova_str);
	return CIDADE_TOMADOR;
}

(<ns3:OrgaoGerador>[ \t\r\n]+<ns3:CodigoMunicipio>{NUMERO}<\/ns3:CodigoMunicipio>) { //CORUMBÁ
	retirar_maiorque_e_menorque(yytext, nova_str, 2);
	converteCodigoEmMunicipio(nova_str, nova_str);
	yylval.string=strdup(nova_str);
	return CIDADE_TOMADOR;
}

(<CodigoMunicipio>{NUMERO}<\/CodigoMunicipio><Uf>{PALAVRA}<\/Uf><Cep>{NUMERO}<\/Cep><\/Endereco><Contato><Telefone>{NUMERO}<\/Telefone><Email>{EMAIL}<\/Email><\/Contato><\/Tomador>) { //JOAO MOLENVADE_1
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	converteCodigoEmMunicipio(nova_str, nova_str);
	yylval.string=strdup(nova_str);
	return CIDADE_TOMADOR;
}

(<CodigoMunicipio>{NUMERO}<\/CodigoMunicipio><Uf>{PALAVRA}<\/Uf><Cep>{NUMERO}<\/Cep><\/Endereco><Contato><Telefone>{NUMERO}<\/Telefone><\/Contato><\/Tomador>) { //JOAO MOLENVADE_2
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	converteCodigoEmMunicipio(nova_str, nova_str);
	yylval.string=strdup(nova_str);
	return CIDADE_TOMADOR;
}


(<CodigoMunicipio>{NUMERO}<\/CodigoMunicipio><Uf>{PALAVRA}<\/Uf><Cep>{NUMERO}<\/Cep><\/Endereco><Contato><Email>{EMAIL}<\/Email><\/Contato><\/TomadorServico>) { //RIO DE JANEIRO 1
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	converteCodigoEmMunicipio(nova_str, nova_str);
	yylval.string=strdup(nova_str);
	return CIDADE_TOMADOR;
}

(<CodigoMunicipio>{NUMERO}<\/CodigoMunicipio><Uf>{PALAVRA}<\/Uf><Cep>{NUMERO}<\/Cep><\/Endereco><Contato><Telefone>{NUMERO}<\/Telefone><Email>{EMAIL}<\/Email><\/Contato><\/TomadorServico>) { //RIO DE JANEIRO 2
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	converteCodigoEmMunicipio(nova_str, nova_str);
	yylval.string=strdup(nova_str);
	return CIDADE_TOMADOR;
}

(<CodigoMunicipio>{NUMERO}<\/CodigoMunicipio><Uf>{PALAVRA}<\/Uf><Cep>{NUMERO}<\/Cep><\/Endereco><\/TomadorServico>) { //RIO DE JANEIRO 3
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	converteCodigoEmMunicipio(nova_str, nova_str);
	yylval.string=strdup(nova_str);
	return CIDADE_TOMADOR;
}


(tsMunTmd>{PALAVRA}<\/tsMunTmd) { //PARAUPEBAS
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	yylval.string=strdup(nova_str);
	return CIDADE_TOMADOR;
}

(<PRESTADOR_CIDADE>{PALAVRA}<\/PRESTADOR_CIDADE>) { //BELÉM
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	yylval.string=strdup(nova_str);
	return CIDADE_PRESTADOR;
}

(<CodigoMunicipio>{NUMERO}<\/CodigoMunicipio><Uf>{PALAVRA}<\/Uf><Cep>{NUMERO}<\/Cep><\/Endereco><Contato><Telefone>{NUMERO}<\/Telefone><Email>{EMAIL}<\/Email><\/Contato><\/PrestadorServico>) { //JOAO MOLENVADE
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	converteCodigoEmMunicipio(nova_str, nova_str);
	yylval.string=strdup(nova_str);
	return CIDADE_PRESTADOR;
}

(<CodigoMunicipio>{NUMERO}<\/CodigoMunicipio><Uf>{PALAVRA}<\/Uf><Cep>{NUMERO}<\/Cep><\/Endereco><Contato><Telefone>{NUMERO}<\/Telefone><\/Contato><\/PrestadorServico>) { //RIO DE JANEIRO 1
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	converteCodigoEmMunicipio(nova_str, nova_str);
	yylval.string=strdup(nova_str);
	return CIDADE_PRESTADOR;
}

(<CodigoMunicipio>{NUMERO}<\/CodigoMunicipio><Uf>{PALAVRA}<\/Uf><\/Endereco><Contato><Telefone>{NUMERO}<\/Telefone><Email>n{EMAIL}<\/Email><\/Contato><\/PrestadorServico>) { //RIO DE JANEIRO 2
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	converteCodigoEmMunicipio(nova_str, nova_str);
	yylval.string=strdup(nova_str);
	return CIDADE_PRESTADOR;
}


(<tsMunSvc>{PALAVRA}<\/tsMunSvc>) { //PARAUPEBAS
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	converteCodigoEmMunicipio(nova_str, nova_str);
	yylval.string=strdup(nova_str);
	return CIDADE_PRESTADOR;
}

(<VALOR_SERVICO>{NUMERO}<\/VALOR_SERVICO>) { //BELÉM
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	yylval.string=strdup(nova_str);
	return VALOR_SERVICO;
}

(<ns3:ValorServicos>{NUMERO}<\/ns3:ValorServicos>) { //CORUMBÁ
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	yylval.string=strdup(nova_str);
	return VALOR_SERVICO;
}


(<ValorServicos>{NUMERO}<\/ValorServicos>) { //JOAO MONLEVADE e RIO DE JANEIRO
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	yylval.string=strdup(nova_str);
	return VALOR_SERVICO;
}

(<tsVlrSvc>{NUMERO}<\/tsVlrSvc>) { //PARAUPEBAS
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	yylval.string=strdup(nova_str);
	return VALOR_SERVICO;
}

(<VALOR_ISS_RET>{NUMERO}<\/VALOR_ISS_RET>) { //BELÉM
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	yylval.string=strdup(nova_str);
	return VALOR_ISS_RET;
}

(<ns3:IssRetido>{NUMERO}<\/ns3:IssRetido>) { //CORUMBÁ
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	yylval.string=strdup(nova_str);
	return VALOR_ISS_RET;
}

(<IssRetido>{NUMERO}<\/IssRetido>) { //JOAO MONLEVADE e RIO DE JANEIRO
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	yylval.string=strdup(nova_str);
	return VALOR_ISS_RET;
}

(<tsVlrISSRet>{NUMERO}<\/tsVlrISSRet>) { //PARAUPEBAS
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	yylval.string=strdup(nova_str);
	return VALOR_ISS_RET;
}


. ;

[ \t\r\n] ;

<<EOF>> {
	return EOL;
}

%%

int yywrap() {
  return 1;
}
