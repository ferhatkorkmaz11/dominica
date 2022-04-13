main			main
if			if
else			else
while			while
for			for
delete			delete		
set_indicator		"_"
func_type		func_
void			void
left_braces		"{"
right_braces		"}"
left_parantheses	"("
right_parantheses	")"
return			return
line_comment_start	"#"
new_line		"\n"
end_of_stmt		";"
ascii_char		[ -~]
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
type_name		int|string|bool|double|elm
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
{main}{left_parantheses}{right_parantheses}							return (MAIN);
{if}												return (IF);
{else}												return (ELSE);
{while}												return (WHILE);
{for}												return (FOR);
{void}												return (VOID_TYPE);
{return}											return (RETURN);
{bool_value}										return (BOOL_VALUE);
{left_braces}										return (LB);
{right_braces}										return (RB);
{left_parantheses}									return (LP);
{right_parantheses}									return (RP);
{comma}												return (COMMA); 
{column}											return (COLUMN); 
{exclamation_mark}									return (NOT_OP);
{and_op}											return (AND_OP);
{or_op}												return (OR_OP);
{assignment_op}										return (ASSIGNMENT_OP);
{equals_op}											return (EQUALS_OP); 
{not_equals_op}										return (NOT_EQUALS_OP);
{greater_than_op}									return (GREATER_THAN_OP); 
{greater_equal_op}									return (GREATER_EQUAL_OP); 
{less_than_op}										return (LESS_THAN_OP);
{less_equal_op}										return (LESS_EQUAL_OP); 
{type_name}											return (VARIABLE_TYPE);
{set_type}											return (SET_VARIABLE_TYPE); 
{plus_sign}											return (ADDITION_OP);
{minus_sign}										return (SUBTRACTION_OP); 
{div_sign}											return (DIVISION_OP);
{mul_sign}											return (MULTIPLICATION_OP); 
{set_add_op}										return (SET_ADDITION_OP);
{set_remove_op}										return (SET_REMOVE_OP);
{set_union_op}										return (SET_UNION_OP);
{set_intersection_op}								return (SET_INTERSECTION_OP); 
{set_difference_op}									return (SET_DIFFERENCE_OP);
{set_cardinality}									return (SET_CARDINALITY);
{set_power_set}										return (SET_POWER_SET);
{set_cartesian}										return (SET_CARTESIAN);
{set_delete_set}									return (SET_DELETE_SET); 
{set_is_subset_of}									return (SET_IS_SUBSET_OF); 
{set_is_superset_of}								return (SET_IS_SUPERSET_OF); 
{set_is_an_element_of}								return (SET_IS_AN_ELEMENT_OF); 
{set_are_disjoint}									return (SET_ARE_DISJOINT);
{scan_primitive}									return (SCAN_INPUT);
{fwrite_primitive}									return (FILE_WRITE);
{fread_primitive}									return (FILE_READ);
{print_primitive}									return (PRINT);
{end_of_stmt}										return (END_OF_STMT); 
{sign}?{digit}+										return (INTEGER_CONST); 
{sign}?{digit}*{dot}?{digit}+						return (DOUBLE_CONST);
{line_comment_start}{ascii_char}*					return (COMMENT);
{quote}{ascii_char}*{quote}							return (STRING_CONST); 
{func_type}{letter_char}({letter_char}|{digit})+	return (FUNCTION_IDENTIFIER); 
{set_indicator}({digit}|{letter_char})+				return (SET_IDENTIFIER);
{letter_char}({letter_char}|{digit})+				return (IDENTIFIER);
{new_line}							{extern int lineno; lineno++;}					
[ \t]								;
.								return (INVALID_CHAR);
%%

int yywrap()
{
	return 1;
}

