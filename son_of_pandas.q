p)import pandas as pd

// Get the data type of each column using python
//.p.qeval"(''.join(['J' if i=='int64' else 'F' if i=='float64' else '*' for i in (pd.read_csv('/home/senthil/Data/Data/Data_Base/CSV_file/apy.csv').dtypes)]))"

//Get the Data type of each column
get_type:{{:.p.qeval x}["(''.join(['J' if i=='int64' else 'F' if i=='float64' else '*' for i in (pd.read_csv('",x,"').dtypes)]))"]}

//Read the csv
read_csv:{(get_type x;enlist csv)0: hsym `$x}

//Check null values in each column
isnull:{flip enlist(cols(x)) ! {sum null t[x]}each cols(x)}