
wfcreate m 2000 2020
%variables="wf page table_name path"
%variables=@wreplace(%variables,"* ","*") 'remove unwanted space
string function_arguments=@replace(%variables," ","="""",")
%variables1=@replace(%variables," ","+@chr(13)+") 'replace space with @CHR(13) to create a NEWLINE (RETURN).
string writeLines=@replace(%variables," ",",") 'create a list for WRITELINES in R
for %y {%variables}
string {%y}=%y+"=paste0('%"+%y+"=',shQuote("+%y+"))"
next
string variablesss={%variables1}
delete {%variables}


