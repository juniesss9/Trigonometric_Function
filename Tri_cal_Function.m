function  [text1,text2,warning2,warning1] = Tri_cal_Function(x,n)
% Tri_cal_Function - ���Ǻ���������
%
% ���������
%   x - ���������������һ���Ƕȣ�Ҳ������һ����ֵ
%   n - ���������Ϊ1�ж�x�ǽǶȣ�Ϊ2�ж�x����ֵ 
%
% �����ʾ��
%   text1,text2 - ̩�ռ���չ������õ������Ǻ���ֵ����MATLAB�������Ǻ������бȽ��Լ�������
%   warning1,warning2 - �Ƿ�����ʱ����������ʾ
    

if n==1
    inputNum=rad2deg(x);
    [y_sin,mat_sin,error_sin]=my_sin(x);
   text1 = ['my_sin(', num2str(inputNum), '��) = ', num2str(y_sin),', matlab_sin(', num2str(inputNum), '��) = ', num2str(mat_sin),', ��matlab��sin�⺯��֮��������� = ', num2str(error_sin)];
    [y_cos,mat_cos,error_cos]=my_cos(x);
   text2 = ['my_cos(', num2str(inputNum), '��) = ', num2str(y_cos),', matlab_cos(', num2str(inputNum), '��) = ', num2str(mat_cos),', ��matlab��cos�⺯��֮��������� = ', num2str(error_cos)];
   warning1 = '';
   warning2 = '';
else
    [y_arctan,mat_arctan,error_arctan,warning2]=my_arctan(x);
   text1 = ['my_arctan(', num2str(x), ') = ', num2str(y_arctan),'��, matlab_arctan(', num2str(x), ') = ', num2str(mat_arctan),'��, ��matlab��arctan�⺯��֮��������� = ', num2str(error_arctan),'��'];
    [y_arcsin,mat_arcsin,error_arcsin,warning1]=my_arcsin(x);
   text2 = ['my_arcsin(', num2str(x), ') = ', num2str(y_arcsin),'��, matlab_arcsin(', num2str(x), ') = ', num2str(mat_arcsin),'��, ��matlab��arcsin�⺯��֮��������� = ', num2str(error_arcsin),'��'];
end
end

%����sin
function [result_sin,mat_sin,error_sin] = my_sin(x)
result_sin = 0;
n = 10; % ̩�ռ���չ�����������Ը�����Ҫ����
for k = 0:n
    result_sin = result_sin + ((-1)^k * x^(2*k+1)) / factorial(2*k+1);
end
mat_sin=sin(x);
error_sin=abs(result_sin-mat_sin)/abs(mat_sin);
end

%����cos
function [result_cos,mat_cos,error_cos]= my_cos(x)
result_cos = 0;
n = 10; % ̩�ռ���չ�����������Ը�����Ҫ����
for k = 0:n
    result_cos = result_cos + ((-1)^k * x^(2*k)) / factorial(2*k);
end
mat_cos=cos(x);
error_cos=abs(result_cos-mat_cos)/abs(mat_cos);
end

%����arcsin ������Χ��-1��1֮��
function [result_arcsin,mat_arcsin,error_arcsin,warning1] = my_arcsin(x)
if x<=1 && x>=-1
    result_arcsin = 0;
    n = 10; % ̩�ռ���չ�����������Ը�����Ҫ����
    for k = 0:n
        result_arcsin = result_arcsin + (factorial(2*k) * x^(2*k+1)) / (4^k * factorial(k)^2 * (2*k+1));
    end
    mat_arcsin=asin(x);
    warning1 = '';
else
    warning1 = 'arcsin����������ֵ����������!';
    result_arcsin=NaN;
    mat_arcsin=NaN;
end
result_arcsin= rad2deg(result_arcsin);
mat_arcsin= rad2deg(mat_arcsin);
error_arcsin= abs(result_arcsin-mat_arcsin)/abs(mat_arcsin);
end

%����arctan ������Χ��-1��1֮��Ľ��Ƽ��㣬��������
function [result_arctan,mat_arctan,error_arctan,warning2] = my_arctan(x)
if x<=1 && x>=-1
    result_arctan = 0;
    n = 30; % ̩�ռ���չ�����������Ը�����Ҫ����
    for k = 0:n
        result_arctan = result_arctan + ((-1)^k * x^(2*k+1)) / (2*k+1);
    end
    mat_arctan=atan(x);
    warning2 = '';
else
    warning2 = 'my_arctan�����������ޣ�������0�������Ƚϸ�!';
    result_arctan=NaN;
    mat_arctan=atan(x);
end
result_arctan = rad2deg(result_arctan);
mat_arctan= rad2deg(mat_arctan);
error_arctan= abs(result_arctan-mat_arctan)/ abs(mat_arctan);
end

%����ת��Ϊ�Ƕ�
function degrees = rad2deg(radians)
degrees = radians * (180 / pi);
end