/Finding null values in every column
/isnull:{flip enlist(cols(value x)) ! {sum null t[x]}each cols(value x)}

isnull:{flip enlist(cols(x)) ! {sum null t[x]}each cols(x)}