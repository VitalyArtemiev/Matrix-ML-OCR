minRows = 1;
maxRows = 6;
minCols = 1;
maxCols = 6;

numToGenerate = 1000;

for i = 1..1000
  r = randi([minRows, maxRows]);
  c = randi([minCols, maxCols]);
  m = rand(r, c)
  
  ms = int2str(m);
  
  s = '';
  
  matrType = randi(6);
  switch maatrType
    case 0
	
	case 1
	
	case 2
  
  end
  
  
end

 
\begin{align*}
x^2 + y^2 &= 1 \\
y &= \sqrt{1 - x^2}
\end{align*}

\left[\begin{array}{@{}ccc|c@{}}
1 & 2 & 3 & 4 \\
1 & 2 & 3 & 4 \\
1 & 2 & 3 & 4 \\
1 & 2 & 3 & 4
\end{array}\right]

\begin{pmatrix}
1 & 2 & 3 & 4 \\
1 & 2 & 3 & 4 \\
1 & 2 & 3 & 4 \\
\hline
1 & 2 & 3 & 4
\end{pmatrix}