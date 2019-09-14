minRows = 2;
maxRows = 6;
minCols = 2;
maxCols = 6;
minInt = - 100;
maxInt = 100;

numToGenerate = 128; %MUST BE POWER OF 2
threshold = numToGenerate / 8;

for i = 1:numToGenerate
  r = randi([minRows, maxRows]);
  c = randi([minCols, maxCols]);
  
  matrType = randi(5);
  
  if i == threshold
    minInt /= 2;
    maxInt /= 2;
	threshold *= 2;
	i
	threshold
  end
  
  m = randi([minInt maxInt], r, c)
  
  doHline = (randi(10) == 1) 
  doVline = (randi(10) == 1)
  
  if matrType == 4
    doVline = 0
	doHline = 0
  end
  
  ms = strrep(strrep(mat2str(m)," ","&"),";","\\\\\n")(2:end-1)
  
  if doHline
    %strcmp('\\', ms)
    %index = find(strcmp('\\', ms))
	index = findstr(ms, '\\') .+ 1
	
	if (rem(r, 2) == 0) && (randi(5) == 1)
	  ms1 = substr(ms, 1, index(r/2))
      ms2 = substr(ms, index(r/2) + 1)
	else
	  ms1 = substr(ms, 1, index(end))
      ms2 = substr(ms, index(end) + 1)
	end
    ms = [ms1 "\n" '\hline' ms2];	
  end
  
  arrayFmt = '';
  if doVline
    if (rem(c, 2) == 0) && (randi(5) == 1)
	
	  t = strcat(repmat('c', 1, c / 2));
	  arrayFmt = ['{' t '|' t '}'];
	else
      arrayFmt = ['{'  strcat(repmat('c', 1, c - 1))  '|c}'];
	end
  else
    arrayFmt = ['{'  strcat(repmat('c', 1, c))  '}'];
  end
  
  
  s = ['\begin{array}'  arrayFmt "\n" ms "\n" '\end{array}'];
  
  %matrix, bmatrix, pmatrix, vmatrix, Vmatrix
  
  switch matrType
    case 1
	  s = s;	
	case 2
	  s = ['\left[' "\n" s "\n" '\right]'];
	case 3
	  s = ['\left(' "\n" s "\n" '\right)'];
	case 4
	  s = ['\left|' "\n" s "\n" '\right|'];
	case 5
      s = ['\begin{Vmatrix}' "\n" ms "\n" '\end{Vmatrix}'];
  end
  
  s 
  
  pars.debug = 0;
  pars.outfile = int2str(i)
  
  latex2png(s, pars);
end