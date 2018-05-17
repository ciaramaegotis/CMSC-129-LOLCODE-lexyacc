%{
#include <stdio.h>
extern FILE *yyin;
int regs[26];
float ITValue = 0;
%}


%token I TROOF_LITERAL OUTTA TYPE_LITERAL OF AN HAI KTHXBYE HAS A ITZ SUM DIFF QUOSHUNT PRODUKT MOD SMALLR BIGGR R SMOOSH VISIBLE BOTH EITHER NOT WON ANY ALL SAEM DIFFRINT MAEK IS NOW GIMMEH O RLY YA OMG OMGWTF MEBBE NO WAI OIC WILE TIL UPPIN NERFIN WTF IM IN YR RLY_Q WTF_Q
%union{
  int number;
  char * string;
  float floatnum;
}
%token <string> IDENTIFIER
%token <number> NUMBR
%token <floatnum> NUMBAR
%token <string> YARN_LITERAL

%left '|'
%left '&'
%left '+' '-'
%left '*' '/' '%'
%left UMINUS  /*supplies precedence for unary minus */
%%                   /* beginning of rules section */

program: HAI program_body KTHXBYE
         {
          printf("Note: valid program");
         };

variable_declaration: I HAS A IDENTIFIER
                      {
                        printf("%s", $4);
                      }
                      |
                      I HAS A IDENTIFIER ITZ YARN_LITERAL
                      |
                      I HAS A IDENTIFIER ITZ NUMBR
                      |
                      I HAS A IDENTIFIER ITZ NUMBAR
                      |
                      I HAS A IDENTIFIER ITZ TROOF_LITERAL

number_expression: SUM OF number_expression AN number_expression
                    {
                      
                      printf("%f", ITValue);
                    }
                   |
                   DIFF OF number_expression AN number_expression
                   {return 3;}
                   |
                   PRODUKT OF number_expression AN number_expression
                   |
                   QUOSHUNT OF number_expression AN number_expression
                   |
                   MOD OF number_expression AN number_expression
                   |
                   BIGGR OF number_expression AN number_expression
                   |
                   SMALLR OF number_expression AN number_expression
                   |
                   NUMBR
                   {ITValue = $1;}
                   |
                   NUMBAR
                   {ITValue = $1;}

troof_expression: TROOF_LITERAL
                  |
                  BOTH OF troof_expression AN troof_expression
                  |
                  BOTH OF troof_expression troof_expression
                  |
                  EITHER OF troof_expression AN troof_expression
                  |
                  EITHER OF troof_expression troof_expression
                  |
                  NOT troof_expression

conditional:

output: VISIBLE troof_expression
        |
        VISIBLE number_expression
        |
        VISIBLE IDENTIFIER;
        |
        VISIBLE YARN_LITERAL
        {
          printf("%s", $2);
        }
        |
        VISIBLE concatenation

concatenation:

variable_assignment:  IDENTIFIER R number_expression
                      |
                      IDENTIFIER R troof_expression
                      |
                      IDENTIFIER R YARN_LITERAL
                      |
                      IDENTIFIER R concatenation


end_case: number_expression
          |
          troof_expression
          |
          variable_declaration
          |
          variable_assignment
          |
          conditional
          |
          output
          |
          concatenation

program_body: end_case
              |
              program_body end_case

%%
main(int argc, char *argv[]){
 yyin = fopen(argv[1], "r");
 return(yyparse());
}
yyerror(s)
char *s;
{
  fprintf(stderr, "%s\n",s);
}
yywrap()
{
  return(1);
}
