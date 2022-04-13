%{
#include <stdio.h>
%}

%token MAIN
%token IF
%token ELSE
%token WHILE
%token FOR
%token VOID_TYPE
%token RETURN
%token BOOL_VALUE
%token LB
%token RB
%token LP
%token RP
%token COMMA 
%token COLUMN 
%token NOT_OP
%token AND_OP
%token OR_OP
%token ASSIGNMENT_OP
%token EQUALS_OP
%token NOT_EQUALS_OP
%token GREATER_THAN_OP 
%token GREATER_EQUAL_OP 
%token LESS_THAN_OP
%token LESS_EQUAL_OP 
%token VARIABLE_TYPE
%token SET_VARIABLE_TYPE 
%token ADDITION_OP
%token SUBTRACTION_OP 
%token DIVISION_OP
%token MULTIPLICATION_OP 
%token SET_ADDITION_OP
%token SET_REMOVE_OP
%token SET_UNION_OP
%token SET_INTERSECTION_OP 
%token SET_DIFFERENCE_OP
%token SET_CARDINALITY
%token SET_POWER_SET
%token SET_CARTESIAN
%token SET_DELETE_SET 
%token SET_IS_SUBSET_OF 
%token SET_IS_SUPERSET_OF 
%token SET_IS_AN_ELEMENT_OF 
%token SET_ARE_DISJOINT
%token SCAN_INPUT
%token FILE_WRITE
%token FILE_READ
%token PRINT
%token END_OF_STMT 
%token INTEGER_CONST 
%token DOUBLE_CONST
%token COMMENT
%token STRING_CONST 
%token FUNCTION_IDENTIFIER 
%token SET_IDENTIFIER
%token IDENTIFIER
%token INVALID_CHAR

%start dominica

%%

dominica:
		 MAIN LB RB
		 |MAIN LB stmt_list RB
         |MAIN LB RB function_list
         |MAIN LB stmt_list RB function_list

function_list:
              function
              |function function_list
	
stmt_list:	  stmt
		  |stmt stmt_list

stmt:
	 expression END_OF_STMT
	 |conditional_stmt 
	 |loop_stmt
	 |COMMENT

conditional_stmt:
			     IF LP logical_arithmetic_expression RP LB stmt_list RB
			     |IF LP logical_arithmetic_expression RP LB RB
			     |IF LP logical_arithmetic_expression RP LB stmt_list RB ELSE LB stmt_list RB
			     |IF LP logical_arithmetic_expression RP LB RB ELSE LB stmt_list RB
			     |IF LP logical_arithmetic_expression RP LB stmt_list RB ELSE LB RB
			     |IF LP logical_arithmetic_expression RP LB RB ELSE LB RB
			     |IF LP logical_arithmetic_expression RP LB stmt_list RB ELSE conditional_stmt
			     |IF LP logical_arithmetic_expression RP LB RB ELSE conditional_stmt
loop_stmt:
		  for_loop 
		  |while_loop

for_loop:
		 reg_for_loop
		 |set_for_loop

reg_for_loop:
 			 FOR LP variable_declaration END_OF_STMT logical_arithmetic_expression END_OF_STMT assignment_expression RP LB stmt_list RB
 			 |FOR LP variable_declaration END_OF_STMT logical_arithmetic_expression END_OF_STMT assignment_expression RP LB RB

set_for_loop:
			FOR LP SET_IDENTIFIER COLUMN SET_IDENTIFIER RP LB stmt_list RB
			|FOR LP SET_IDENTIFIER COLUMN SET_IDENTIFIER RP LB RB
			|FOR LP SET_IDENTIFIER COLUMN INTEGER_CONST COLUMN SET_IDENTIFIER RP LB stmt_list RB
			|FOR LP SET_IDENTIFIER COLUMN INTEGER_CONST COLUMN SET_IDENTIFIER RP LB RB
			|FOR LP SET_IDENTIFIER COLUMN INTEGER_CONST COLUMN IDENTIFIER RP LB stmt_list RB
			|FOR LP SET_IDENTIFIER COLUMN INTEGER_CONST COLUMN IDENTIFIER RP LB RB

while_loop:
		   WHILE LP logical_arithmetic_expression RP LB stmt_list RB
		   |WHILE LP logical_arithmetic_expression RP LB RB

set:
    LB RB
    |LB set_init_list RB

set_init_list:
			  IDENTIFIER
			  |type
			  |IDENTIFIER COMMA set_init_list
			  |type COMMA set_init_list
type:
	 INTEGER_CONST
	 |STRING_CONST
	 |DOUBLE_CONST
	 |BOOL_VALUE

logical_arithmetic_expression:
				   regular_logic_arithmetic
				   |set_logic
				   |logical_arithmetic_expression AND_OP regular_logic_arithmetic
				   |logical_arithmetic_expression OR_OP regular_logic_arithmetic
				   |logical_arithmetic_expression AND_OP set_logic			
				   |logical_arithmetic_expression OR_OP  set_logic

regular_logic_arithmetic:
			  BOOL_VALUE
			  |BOOL_VALUE EQUALS_OP BOOL_VALUE
			  |BOOL_VALUE NOT_EQUALS_OP BOOL_VALUE
			  |arithmetic_operation
			  |NOT_OP LP logical_arithmetic_expression RP
			  |arithmetic_operation EQUALS_OP BOOL_VALUE
			  |arithmetic_operation NOT_EQUALS_OP BOOL_VALUE
			  |arithmetic_operation EQUALS_OP arithmetic_operation
			  |arithmetic_operation NOT_EQUALS_OP arithmetic_operation
			  |arithmetic_operation GREATER_EQUAL_OP arithmetic_operation
			  |arithmetic_operation LESS_EQUAL_OP arithmetic_operation
			  |arithmetic_operation GREATER_THAN_OP arithmetic_operation
			  |arithmetic_operation LESS_THAN_OP arithmetic_operation


set_logic: 
	      IDENTIFIER SET_IS_AN_ELEMENT_OF set
	      |type SET_IS_AN_ELEMENT_OF set
	      |IDENTIFIER SET_IS_AN_ELEMENT_OF SET_IDENTIFIER
	      |type SET_IS_AN_ELEMENT_OF SET_IDENTIFIER
	      |set_operation SET_IS_SUBSET_OF set_operation
	      |set_operation SET_IS_SUPERSET_OF set_operation
	      |set_operation SET_ARE_DISJOINT set_operation

expression: 
		   variable_declaration
		   |assignment_expression
		   |function_call
		   |set_expression
		   |set_declaration
		   |set_assignment

variable_declaration:
					 VARIABLE_TYPE IDENTIFIER ASSIGNMENT_OP STRING_CONST
					 |VARIABLE_TYPE IDENTIFIER ASSIGNMENT_OP logical_arithmetic_expression
					 |VARIABLE_TYPE IDENTIFIER ASSIGNMENT_OP function_call

assignment_expression:
 					  IDENTIFIER ASSIGNMENT_OP STRING_CONST
					  |IDENTIFIER ASSIGNMENT_OP logical_arithmetic_expression
					  |IDENTIFIER ASSIGNMENT_OP function_call

arithmetic_plus_min_sign:
						 ADDITION_OP
						 |SUBTRACTION_OP

arithmetic_mul_div_sign:
						MULTIPLICATION_OP
						|DIVISION_OP


arithmetic_operation:
					 arithmetic_term
					 |arithmetic_operation arithmetic_plus_min_sign arithmetic_term

arithmetic_term:
				arithmetic_factor
				|arithmetic_term arithmetic_mul_div_sign arithmetic_factor

arithmetic_factor:
				  LP arithmetic_operation RP
				  |IDENTIFIER
				  |INTEGER_CONST
				  |DOUBLE_CONST

set_declaration:
				SET_VARIABLE_TYPE SET_IDENTIFIER ASSIGNMENT_OP set_operation
				|SET_VARIABLE_TYPE SET_IDENTIFIER ASSIGNMENT_OP function_call

set_assignment:
 			   SET_IDENTIFIER ASSIGNMENT_OP set_operation
 			   |SET_IDENTIFIER ASSIGNMENT_OP function_call

set_expression:
			   SET_IDENTIFIER SET_ADDITION_OP type
			   |SET_IDENTIFIER SET_REMOVE_OP type
			   |SET_IDENTIFIER SET_ADDITION_OP IDENTIFIER
			   |SET_IDENTIFIER SET_REMOVE_OP IDENTIFIER
			   |SET_DELETE_SET SET_IDENTIFIER

set_operation:
			  set_term
			  |set_operation SET_INTERSECTION_OP set_term
			  |set_operation SET_DIFFERENCE_OP set_term
			  |set_operation SET_UNION_OP set_term

set_term:
		 SET_IDENTIFIER
		 |set
		 |LP set_operation RP

function:
		 VARIABLE_TYPE FUNCTION_IDENTIFIER LP RP LB stmt_list RETURN IDENTIFIER END_OF_STMT stmt_list RB
		 |VARIABLE_TYPE FUNCTION_IDENTIFIER LP RP LB RETURN IDENTIFIER END_OF_STMT stmt_list RB
		 |VARIABLE_TYPE FUNCTION_IDENTIFIER LP RP LB stmt_list RETURN IDENTIFIER END_OF_STMT RB
		 |VARIABLE_TYPE FUNCTION_IDENTIFIER LP RP LB RETURN IDENTIFIER END_OF_STMT RB
		 |VARIABLE_TYPE FUNCTION_IDENTIFIER LP RP LB stmt_list RETURN type END_OF_STMT stmt_list RB
		 |VARIABLE_TYPE FUNCTION_IDENTIFIER LP RP LB RETURN type END_OF_STMT stmt_list RB
		 |VARIABLE_TYPE FUNCTION_IDENTIFIER LP RP LB stmt_list RETURN type END_OF_STMT RB
		 |VARIABLE_TYPE FUNCTION_IDENTIFIER LP RP LB RETURN type END_OF_STMT RB
		 |VARIABLE_TYPE FUNCTION_IDENTIFIER LP param_list RP LB stmt_list RETURN IDENTIFIER END_OF_STMT stmt_list RB
		 |VARIABLE_TYPE FUNCTION_IDENTIFIER LP param_list RP LB RETURN IDENTIFIER END_OF_STMT stmt_list RB
		 |VARIABLE_TYPE FUNCTION_IDENTIFIER LP param_list RP LB stmt_list RETURN IDENTIFIER END_OF_STMT RB
		 |VARIABLE_TYPE FUNCTION_IDENTIFIER LP param_list RP LB RETURN IDENTIFIER END_OF_STMT RB
		 |VARIABLE_TYPE FUNCTION_IDENTIFIER LP param_list RP LB stmt_list RETURN type END_OF_STMT stmt_list  RB
		 |VARIABLE_TYPE FUNCTION_IDENTIFIER LP param_list RP LB RETURN type END_OF_STMT stmt_list  RB
		 |VARIABLE_TYPE FUNCTION_IDENTIFIER LP param_list RP LB stmt_list RETURN type END_OF_STMT RB
		 |VARIABLE_TYPE FUNCTION_IDENTIFIER LP param_list RP LB RETURN type END_OF_STMT RB
		 |SET_VARIABLE_TYPE FUNCTION_IDENTIFIER LP RP LB stmt_list RETURN SET_IDENTIFIER END_OF_STMT stmt_list RB
		 |SET_VARIABLE_TYPE FUNCTION_IDENTIFIER LP RP LB RETURN SET_IDENTIFIER END_OF_STMT stmt_list RB
		 |SET_VARIABLE_TYPE FUNCTION_IDENTIFIER LP RP LB stmt_list RETURN SET_IDENTIFIER END_OF_STMT RB
		 |SET_VARIABLE_TYPE FUNCTION_IDENTIFIER LP RP LB RETURN SET_IDENTIFIER END_OF_STMT RB
		 |SET_VARIABLE_TYPE FUNCTION_IDENTIFIER LP RP LB stmt_list RETURN set END_OF_STMT stmt_list  RB
		 |SET_VARIABLE_TYPE FUNCTION_IDENTIFIER LP RP LB RETURN set END_OF_STMT stmt_list  RB
		 |SET_VARIABLE_TYPE FUNCTION_IDENTIFIER LP RP LB stmt_list RETURN set END_OF_STMT RB
		 |SET_VARIABLE_TYPE FUNCTION_IDENTIFIER LP RP LB RETURN set END_OF_STMT RB
		 |SET_VARIABLE_TYPE FUNCTION_IDENTIFIER LP param_list RP LB stmt_list RETURN SET_IDENTIFIER END_OF_STMT stmt_list RB
		 |SET_VARIABLE_TYPE FUNCTION_IDENTIFIER LP param_list RP LB RETURN SET_IDENTIFIER END_OF_STMT stmt_list RB
		 |SET_VARIABLE_TYPE FUNCTION_IDENTIFIER LP param_list RP LB stmt_list RETURN SET_IDENTIFIER END_OF_STMT RB
		 |SET_VARIABLE_TYPE FUNCTION_IDENTIFIER LP param_list RP LB RETURN SET_IDENTIFIER END_OF_STMT RB
		 |SET_VARIABLE_TYPE FUNCTION_IDENTIFIER LP param_list RP LB stmt_list RETURN set END_OF_STMT stmt_list RB
		 |SET_VARIABLE_TYPE FUNCTION_IDENTIFIER LP param_list RP LB RETURN set END_OF_STMT stmt_list RB
		 |SET_VARIABLE_TYPE FUNCTION_IDENTIFIER LP param_list RP LB stmt_list RETURN set END_OF_STMT RB
		 |SET_VARIABLE_TYPE FUNCTION_IDENTIFIER LP param_list RP LB RETURN set END_OF_STMT RB
	     |VOID_TYPE FUNCTION_IDENTIFIER LP RP LB stmt_list RB
	     |VOID_TYPE FUNCTION_IDENTIFIER LP RP LB RB
		 |VOID_TYPE FUNCTION_IDENTIFIER LP RP LB stmt_list RETURN END_OF_STMT stmt_list RB
		 |VOID_TYPE FUNCTION_IDENTIFIER LP RP LB RETURN END_OF_STMT stmt_list RB
		 |VOID_TYPE FUNCTION_IDENTIFIER LP RP LB stmt_list RETURN END_OF_STMT RB
		 |VOID_TYPE FUNCTION_IDENTIFIER LP RP LB RETURN END_OF_STMT RB
	     |VOID_TYPE FUNCTION_IDENTIFIER LP param_list RP LB stmt_list RB
	     |VOID_TYPE FUNCTION_IDENTIFIER LP param_list RP LB RB
	     |VOID_TYPE FUNCTION_IDENTIFIER LP param_list RP LB stmt_list RETURN END_OF_STMT stmt_list RB
	     |VOID_TYPE FUNCTION_IDENTIFIER LP param_list RP LB RETURN END_OF_STMT stmt_list RB
	     |VOID_TYPE FUNCTION_IDENTIFIER LP param_list RP LB stmt_list RETURN END_OF_STMT RB
	     |VOID_TYPE FUNCTION_IDENTIFIER LP param_list RP LB RETURN END_OF_STMT RB


function_call:
			  FUNCTION_IDENTIFIER LP RP
			  |FUNCTION_IDENTIFIER LP arg_list RP
			  |primitive_function_call

primitive_function_call:
					    SET_CARDINALITY LP set_operation RP
					    |SET_POWER_SET LP set_operation RP
					    |SET_CARTESIAN LP set_operation COMMA set_operation RP
					    |PRINT LP set_operation RP
					    |PRINT LP STRING_CONST RP
					    |PRINT LP IDENTIFIER RP
					    |SCAN_INPUT LP IDENTIFIER RP
					    |SCAN_INPUT LP SET_IDENTIFIER RP
					    |FILE_READ LP STRING_CONST RP
					    |FILE_WRITE LP STRING_CONST COMMA STRING_CONST RP
					    |FILE_WRITE LP IDENTIFIER COMMA STRING_CONST RP
					    |FILE_WRITE LP set_operation COMMA STRING_CONST RP
arg_list:
		 logical_arithmetic_expression
		 |STRING_CONST
		 |SET_IDENTIFIER
		 |logical_arithmetic_expression COMMA arg_list
		 |SET_IDENTIFIER COMMA arg_list
		 |STRING_CONST COMMA arg_list

param_list:
		   VARIABLE_TYPE IDENTIFIER
		   |VARIABLE_TYPE IDENTIFIER COMMA param_list
		   |SET_VARIABLE_TYPE SET_IDENTIFIER
		   |SET_VARIABLE_TYPE SET_IDENTIFIER COMMA param_list


%%
#include "lex.yy.c"
int lineno=1;
void yyerror(char *s) {
	printf("Syntax error on line %d!\n", lineno);
}
int main(void){
 yyparse();
if(yynerrs < 1)
{
		printf("Input program is valid\n");	
}
 return 0;
}
