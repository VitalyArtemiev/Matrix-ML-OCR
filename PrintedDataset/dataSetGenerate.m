minRows = 2;
maxRows = 6;
minCols = 1;
maxCols = 6;
minInt = - 100;
maxInt = 100;

numToGenerate = 1024; %MUST BE POWER OF 2
threshold = numToGenerate / 8;

for counter = 1:numToGenerate
  filename = int2str(counter);
  
  r = randi([minRows, maxRows]);
  c = randi([minCols, maxCols]);
  
  matrType = randi(8);
  switch matrType 
    case 6;
	  matrType = 2;
	case {7, 8}
	  matrType = 3;
  end
   
  if i == threshold
    minInt /= 2;
    maxInt /= 2;
	threshold *= 2;
  end
  
  m = randi([minInt maxInt], r, c);
  
  doHline = (randi(10) == 1); 
  doVline = (randi(10) == 1);
  
  if c == 1
    matrType = 3;
	doVline = 0;
	doHline = 0;
  end
  
  if matrType >= 4
    doVline = 0;
	doHline = 0;
  end
  
  ms = strrep(strrep(mat2str(m)," ","&"),";","\\\\\n")(2:end-1);
  
  if doHline
    filename = ['h' filename];
	index = findstr(ms, '\\') .+ 1;
	
	if (rem(r, 2) == 0) && (randi(5) == 1);
	  ms1 = substr(ms, 1, index(r/2));
      ms2 = substr(ms, index(r/2) + 1);
	else
	  ms1 = substr(ms, 1, index(end));
      ms2 = substr(ms, index(end) + 1);
	end
    ms = [ms1 "\n" '\hline' ms2];	
  else
    filename = ['_' filename];
  end
  
  arrayFmt = '';
  if doVline
    filename = ['v' filename];
    if (rem(c, 2) == 0) && (randi(5) == 1)
	
	  t = strcat(repmat('c', 1, c / 2));
	  arrayFmt = ['{' t '|' t '}'];
	else
      arrayFmt = ['{'  strcat(repmat('c', 1, c - 1))  '|c}'];
	end
  else
    filename = ['_' filename];
    arrayFmt = ['{'  strcat(repmat('c', 1, c))  '}'];
  end
  
  %alignment comment
  s = ['\begin{array}'  arrayFmt "\n" ms "\n" '\end{array}'];
  
  %matrix, bmatrix, pmatrix, vmatrix, Vmatrix
  
  switch matrType
    case 1
	  s = s;
	  filename = ['mi' filename]; 
	case 2
	  s = ['\left[' "\n" s "\n" '\right]'];
	  filename = ['bi' filename];
	case 3
	  s = ['\left(' "\n" s "\n" '\right)'];
	  filename = ['pi' filename];
	case 4
	  s = ['\left|' "\n" s "\n" '\right|'];
	  filename = ['li' filename];
	case 5
      s = ['\begin{Vmatrix}' "\n" ms "\n" '\end{Vmatrix}'];
	  filename = ['Vi' filename];
  end
  
  pars.debug = false;
  pars.outfile = filename;  
  latex2png(s, pars);
end