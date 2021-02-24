import java.util.*;
import java.lang.Character;

%%
%class simp
%standalone
%unicode
%line
%column

LineTerminator = \r|\n|\r\n

InputCharacter = [^\r\n]

WhiteSpace = { LineTerminator}|[ \t\f]


Type = int|int []|boolean|{Identifier}

BinOper = "+"|"-"|"*"|"/"|">"|"<"

Identifier = [a-zA-Z][a-zA-z0-9_]*
DecIntegerLiteral = 0|[1-9][0-9]*
VarDeclaration = {Type} {Identifier}";"

Method = "public"{Type}{Identifier} "(" ( {Type} {Identifier} ( "," {Type} {Identifier} )* )? ")" "{" ( {VarDeclaration} )* ( {Statement} )* "return" {Expression} ";" "}"

Expression = "{"{InputCharacter}*"}"



%{
    int Curl = 0;

    String line = "";

    public String tabber(int num){
        String tabs = "";
        for(int i = 0; i < num; i++){
            tabs = tabs + "\t";
        }
        return tabs;
    }

%}

%eof{
    System.out.print(line);

%eof}


%%




<YYINITIAL> {


    /* whitespace */
    "=" {line = line + " " + yytext() + " "; }

    ";" {line = line + yytext()  + "\n" + tabber(Curl); }

    {Type} { line = line + yytext() + " "; }

    {Identifier} { line = line + yytext() + " "; }

    {DecIntegerLiteral} { line = line + yytext() + " "; }
    
    "{" { 
        Curl = Curl + 1;
        line = line + (Curl + "{\n") + tabber(Curl); 
    }

    "}" { 
        int Lsize = line.length();
        Curl = Curl - 1;
        line = line.substring(0, Lsize - Curl) + "}\n";
  
    }


    {WhiteSpace} {/*nothing*/}

}





