%option main
main			main
if			if
else			else
while			while
for			for
delete			delete		
set_indicator		"_"
func_type		func_
left_braces		"{"
right_braces		"}"
left_parantheses	"("
right_parantheses	")"
return			return
line_comment_start	"#"
new_line		"\n"
end_of_stmt		";"
ascii_char		[ -!#-~]
letter_char		[a-zA-Z]
digit			[0-9]
quote			"\""
column			":"
exclamation_mark	"!"
and_op			"&&"
or_op			"||"
equals_op		"=="
not_equals_op		"!="
greater_than_op		">"
greater_equal_op	">="
less_than_op		"<"
less_equal_op		"<="
assignment_op		"="
comma			","
dot			"\."
mul_div_sign		[\*|/]
sign			[+-]
plus_sign		"\+"
minus_sign		"\-"
div_sign		"/"
mul_sign		"\*"
type_name		int|string|bool|double
element_type_name	elm
bool_value		true|false	
set_type		set
set_add_op		"++"
set_remove_op		"--"
set_union_op		"U"
set_intersection_op	"\^"
set_difference_op	"\\"
set_cardinality		"n"
set_power_set		pow
set_cartesian		cartesian
set_delete_set		delete
set_is_subset_of	"C"
set_is_superset_of	"@"
set_is_an_element_of	"E"
set_are_disjoint	"D"
scan_primitive		scan
fwrite_primitive	fwrite
fread_primitive		fread			
print_primitive		print
%%
{main}							printf("MAIN ");
{if}							printf("IF ");
{else}							printf("ELSE ");
{while}							printf("WHILE ");
{for}							printf("FOR ");
{return}						printf("RETURN ");
{bool_value}						printf("BOOL_VALUE ");
{left_braces}						printf("LB ");
{right_braces}						printf("RB ");
{left_parantheses}					printf("LP ");
{right_parantheses}					printf("RP ");
{comma}							printf("COMMA ");
{column}						printf("COLUMN ");
{exclamation_mark}					printf("NOT_OP ");
{and_op}						printf("AND_OP ");
{or_op}							printf("OR_OP ");
{assignment_op}						printf("ASSIGNMENT_OP ");
{equals_op}						printf("EQUALS_OP ");
{not_equals_op}						printf("NOT_EQUALS_OP ");
{greater_than_op}					printf("GREATER_THAN_OP ");
{greater_equal_op}					printf("GREATER_EQUAL_OP ");
{less_than_op}						printf("LESS_THAN_OP ");
{less_equal_op}						printf("LESS_EQUAL_OP ");
{type_name}						printf("VARIABLE_TYPE ");
{element_type_name}					printf("SET_ELEMENT_TYPE ");
{set_type}						printf("SET_VARIABLE_TYPE ");
{new_line}						printf("NEW_LINE\n");
{plus_sign}						printf("ADDITION_OP ");
{minus_sign}						printf("SUBTRACTION_OP ");
{div_sign}						printf("DIVISION_OP ");
{mul_sign}						printf("MULTIPLICATION_OP ");
{set_add_op}						printf("SET_ADDITION_OP ");
{set_remove_op}						printf("SET_REMOVE_OP ");
{set_union_op}						printf("SET_UNION_OP ");
{set_intersection_op}					printf("SET_INTERSECTION_OP ");
{set_difference_op}					printf("SET_DIFFERENCE_OP ");
{set_cardinality}					printf("SET_CARDINALITY ");
{set_power_set}						printf("SET_POWER_SET ");
{set_cartesian}						printf("SET_CARTESIAN ");
{set_delete_set}					printf("SET_DELETE_SET ");
{set_is_subset_of}					printf("SET_IS_SUBSET_OF ");
{set_is_superset_of}					printf("SET_IS_SUPERSET_OF ");
{set_is_an_element_of}					printf("SET_IS_AN_ELEMENT_OF ");
{set_are_disjoint}					printf("SET_ARE_DISJOINT ");
{scan_primitive}					printf("SCAN_INPUT ");
{fwrite_primitive}					printf("FILE_WRITE ");
{fread_primitive}					printf("FILE_READ ");
{print_primitive}					printf("PRINT ");
{end_of_stmt}						printf("END_OF_STMT ");
{sign}?{digit}+						printf("INTEGER_CONST ");
{sign}?{digit}*{dot}?{digit}+				printf("DOUBLE_CONST ");
{line_comment_start}{ascii_char}*			printf("COMMENT ");
{quote}{ascii_char}*{quote}				printf("STRING_CONST ");
{func_type}{letter_char}({letter_char}|{digit})+	printf("FUNCTION_IDENTIFIER ");
{set_indicator}({digit}|{letter_char})+			printf("SET_IDENTIFIER ");
{letter_char}({letter_char}|{digit})+			printf("IDENTIFIER ");
.							printf("");

