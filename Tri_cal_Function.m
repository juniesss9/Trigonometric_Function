function  [text1,text2,warning2,warning1] = Tri_cal_Function(x,n)
% Tri_cal_Function - 三角函数计算器
%
% 输入参数：
%   x - 输入变量，可以是一个角度，也可以是一个数值
%   n - 输入变量，为1判断x是角度，为2判断x是数值 
%
% 输出显示：
%   text1,text2 - 泰勒级数展开计算得到的三角函数值，与MATLAB内置三角函数进行比较以及相对误差
%   warning1,warning2 - 非法输入时弹出警告提示
    

if n==1
    inputNum=rad2deg(x);
    [y_sin,mat_sin,error_sin]=my_sin(x);
   text1 = ['my_sin(', num2str(inputNum), '°) = ', num2str(y_sin),', matlab_sin(', num2str(inputNum), '°) = ', num2str(mat_sin),', 与matlab的sin库函数之间的相对误差 = ', num2str(error_sin)];
    [y_cos,mat_cos,error_cos]=my_cos(x);
   text2 = ['my_cos(', num2str(inputNum), '°) = ', num2str(y_cos),', matlab_cos(', num2str(inputNum), '°) = ', num2str(mat_cos),', 与matlab的cos库函数之间的相对误差 = ', num2str(error_cos)];
   warning1 = '';
   warning2 = '';
else
    [y_arctan,mat_arctan,error_arctan,warning2]=my_arctan(x);
   text1 = ['my_arctan(', num2str(x), ') = ', num2str(y_arctan),'°, matlab_arctan(', num2str(x), ') = ', num2str(mat_arctan),'°, 与matlab的arctan库函数之间的相对误差 = ', num2str(error_arctan),'°'];
    [y_arcsin,mat_arcsin,error_arcsin,warning1]=my_arcsin(x);
   text2 = ['my_arcsin(', num2str(x), ') = ', num2str(y_arcsin),'°, matlab_arcsin(', num2str(x), ') = ', num2str(mat_arcsin),'°, 与matlab的arcsin库函数之间的相对误差 = ', num2str(error_arcsin),'°'];
end
end

%计算sin
function [result_sin,mat_sin,error_sin] = my_sin(x)
result_sin = 0;
n = 10; % 泰勒级数展开项数，可以根据需要调整
for k = 0:n
    result_sin = result_sin + ((-1)^k * x^(2*k+1)) / factorial(2*k+1);
end
mat_sin=sin(x);
error_sin=abs(result_sin-mat_sin)/abs(mat_sin);
end

%计算cos
function [result_cos,mat_cos,error_cos]= my_cos(x)
result_cos = 0;
n = 10; % 泰勒级数展开项数，可以根据需要调整
for k = 0:n
    result_cos = result_cos + ((-1)^k * x^(2*k)) / factorial(2*k);
end
mat_cos=cos(x);
error_cos=abs(result_cos-mat_cos)/abs(mat_cos);
end

%计算arcsin 定义域范围是-1到1之间
function [result_arcsin,mat_arcsin,error_arcsin,warning1] = my_arcsin(x)
if x<=1 && x>=-1
    result_arcsin = 0;
    n = 10; % 泰勒级数展开项数，可以根据需要调整
    for k = 0:n
        result_arcsin = result_arcsin + (factorial(2*k) * x^(2*k+1)) / (4^k * factorial(k)^2 * (2*k+1));
    end
    mat_arcsin=asin(x);
    warning1 = '';
else
    warning1 = 'arcsin函数输入数值超出定义域!';
    result_arcsin=NaN;
    mat_arcsin=NaN;
end
result_arcsin= rad2deg(result_arcsin);
mat_arcsin= rad2deg(mat_arcsin);
error_arcsin= abs(result_arcsin-mat_arcsin)/abs(mat_arcsin);
end

%计算arctan 定义域范围是-1到1之间的近似计算，精度有限
function [result_arctan,mat_arctan,error_arctan,warning2] = my_arctan(x)
if x<=1 && x>=-1
    result_arctan = 0;
    n = 30; % 泰勒级数展开项数，可以根据需要调整
    for k = 0:n
        result_arctan = result_arctan + ((-1)^k * x^(2*k+1)) / (2*k+1);
    end
    mat_arctan=atan(x);
    warning2 = '';
else
    warning2 = 'my_arctan函数精度有限，输入在0附近精度较高!';
    result_arctan=NaN;
    mat_arctan=atan(x);
end
result_arctan = rad2deg(result_arctan);
mat_arctan= rad2deg(mat_arctan);
error_arctan= abs(result_arctan-mat_arctan)/ abs(mat_arctan);
end

%弧度转化为角度
function degrees = rad2deg(radians)
degrees = radians * (180 / pi);
end