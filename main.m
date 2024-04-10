inputText = input('请输入一个角度：', 's'); % 获取用户输入的文本文字
inputNum = str2double(inputText); % 将文本文字转换为数值
if isnan(inputNum) || ~isnumeric(inputNum) % 判断用户输入的是否为数值
    disp('输入错误，请输入一个数值。');
else
    disp(['你输入的角度是：', num2str(inputNum),'°']);
    x=deg2rad(inputNum);
    %x=inputNum;
    
    [y_sin,mat_sin,error_sin]=my_sin(x);
    disp(['my_sin(', num2str(inputNum), '°) = ', num2str(y_sin),', matlab_sin(', num2str(inputNum), '°) = ', num2str(mat_sin),', 与matlab的sin库函数之间的误差 = ', num2str(error_sin)]);
    [y_cos,mat_cos,error_cos]=my_cos(x);
    disp(['my_cos(', num2str(inputNum), '°) = ', num2str(y_cos),', matlab_cos(', num2str(inputNum), '°) = ', num2str(mat_cos),', 与matlab的cos库函数之间的误差 = ', num2str(error_cos)]);
    [y_arctan,mat_arctan,error_arctan]=my_arctan(x);
    disp(['my_arctan(', num2str(inputNum), '°) = ', num2str(y_arctan),'°, matlab_arctan(', num2str(inputNum), '°) = ', num2str(mat_arctan),'°, 与matlab的arctan库函数之间的误差 = ', num2str(error_arctan),'°']);
    [y_arcsin,mat_arcsin,error_arcsin]=my_arcsin(x);
    disp(['my_arcsin(', num2str(inputNum), '°) = ', num2str(y_arcsin),'°, matlab_arcsin(', num2str(inputNum), '°) = ', num2str(mat_arcsin),'°, 与matlab的arcsin库函数之间的误差 = ', num2str(error_arcsin),'°']);
    
end

%计算sin
function [result_sin,mat_sin,error_sin] = my_sin(x)
    result_sin = 0;
    n = 10; % 泰勒级数展开项数，可以根据需要调整
    for k = 0:n
        result_sin = result_sin + ((-1)^k * x^(2*k+1)) / factorial(2*k+1);
    end
    mat_sin=sin(x);
    error_sin=abs(result_sin-mat_sin);
end

%计算cos
function [result_cos,mat_cos,error_cos]= my_cos(x)
    result_cos = 0;
    n = 10; % 泰勒级数展开项数，可以根据需要调整
    for k = 0:n
        result_cos = result_cos + ((-1)^k * x^(2*k)) / factorial(2*k);
    end
    mat_cos=cos(x);
    error_cos=abs(result_cos-mat_cos);
end

%计算arcsin 定义域范围是-1到1之间
function [result_arcsin,mat_arcsin,error_arcsin] = my_arcsin(x)
if x<=1 && x>=-1
    result_arcsin = 0;
    n = 10; % 泰勒级数展开项数，可以根据需要调整
    for k = 0:n
        result_arcsin = result_arcsin + (factorial(2*k) * x^(2*k+1)) / (4^k * factorial(k)^2 * (2*k+1));
    end
    mat_arcsin=asin(x);
else
    disp('arcsin函数输入数值超出定义域');
    result_arcsin=NaN;
    mat_arcsin=NaN;
end
result_arcsin= rad2deg(result_arcsin);
mat_arcsin= rad2deg(mat_arcsin);
error_arcsin= result_arcsin-mat_arcsin;
end

%计算arctan 定义域范围是-1到1之间的近似计算，精度有限
function [result_arctan,mat_arctan,error_arctan] = my_arctan(x)
if x<=1 && x>=-1
    result_arctan = 0;
    n = 10; % 泰勒级数展开项数，可以根据需要调整
    for k = 0:n
        result_arctan = result_arctan + ((-1)^k * x^(2*k+1)) / (2*k+1);
    end
    mat_arctan=atan(x); 
else
    disp('my_arctan函数精度有限');
    result_arctan=NaN;
    mat_arctan=atan(x);
end
result_arctan = rad2deg(result_arctan);
mat_arctan= rad2deg(mat_arctan);
error_arctan= result_arctan-mat_arctan;
end

function degrees = rad2deg(radians)
    degrees = radians * (180 / pi);
end
