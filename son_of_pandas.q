p)import pandas as pd

// Get the data type of each column using python
//.p.qeval"(''.join(['J' if i=='int64' else 'F' if i=='float64' else '*' for i in (pd.read_csv('/home/senthil/Data/Data/Data_Base/CSV_file/apy.csv').dtypes)]))"

//Get the Data type of each column
get_type:{{:.p.qeval x}["(''.join(['J' if i=='int64' else 'F' if i=='float64' else '*' for i in (pd.read_csv('",x,"').dtypes)]))"]}

//Read the csv
read_csv:{(get_type x;enlist csv)0: hsym `$x}

/read JSON
read_json:{.j.k raze read0 hsym`$x}

/ Percentail function is for find IQR
Percentile:{[x;p]
    x:asc x;
    n: count x;
    k : `long$((p%100) * n);
    $[k=0;
        :x[0];
        k = n;
        :x[-1];
        [d: (((p % 100) * n) - k);
        res:(x[k-1] + (d * (x[k] - x[k-1])));
        :res]
        ]
    };

/ describe function for stastical infrence 
describe:{
    cl: (cols x) where ((0!(meta x))[`t] in ("i";"j";"f"));
    indx:([] (Stats):(`count;`mean;`std;`min;`$"25%";`$"50%";`$"75%";`max));
    res :(indx ^ (flip (cl)!{(count;avg;dev;min;Percentile[;25];Percentile[;50];Percentile[;75];max)@\: x}'[x[cl]]));
    :res
    };

/check isnull
isnull:{[x] tbl::x;flip enlist(cols(x)) ! {[y] sum all each null tbl[y]}each cols(x)}

/Drop NA
drop_idx:{where {[x] tbl::x;{any all each null tbl[x]}each til count(tbl)}x}
/dropna:{[x] tbl::x; tbl:{![tbl; enlist (=;i;x);0b;symbol$()]}each drop_idx x;}
drop_id: {(drop_idx x) - til count(drop_idx x)}
dropna:{[x] tbl::x;{`tbl set delete from tbl where i=x} each (drop_id x); :tbl}

/Fill NA only for columns
fillna:{0 ^ x}

/Describe get all numerics columns and show statics description
Count:{count x}
mean:{"F"$.Q.f [2;] sum x%count x}
stdev:{dev x}


/values counts
values_count: {count each group x}

/Viewing/Inspecting Data
/head: {[x;y:5] select from x where i < y}
shape:{:enlist(count x;count cols x)}

sort:{[x;y;z] tbl::x;{(uj/) (enlist tbl[x])}'[where tbl[y] > z]} //#inprogress
