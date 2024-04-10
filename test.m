%测试程序
%获取用户输入类型，按照类型计算三角函数，为1，则计算sin、cos；为2，则计算arcsin、arctan
%获取用户输入数字，并提示输入是否有误，有误则提示重新输入，无误显示数字并计算三角函数、MATLAB内置函数以及其相对误差

input_switch = input('请选择输入角度（1）还是数值（2）：', 's'); % 获取用户输入类型
switch_num=str2double(input_switch); % 将文本文字转换为数字
switch switch_num
    case 1
        inputText1 = input('请输入一个角度：', 's'); % 获取用户输入角度的文本文字
        inputNum1 = str2double(inputText1); % 将文本文字转换为数字
        if isnan(inputNum1) || ~isnumeric(inputNum1) % 判断用户输入的是否为数字
            disp('输入错误，请输入一个数字。');
        else
            disp(['你输入的角度是：', num2str(inputNum1),'°']);
            x1=deg2rad(inputNum1);
            Tri_cal_Function(x1,1);
        end
    case 2
        inputText2 = input('请输入一个数值：', 's'); % 获取用户输入数值的文本文字
        inputNum2 = str2double(inputText2); % 将文本文字转换为数字
        if isnan(inputNum2) || ~isnumeric(inputNum2) % 判断用户输入的是否为数字
            disp('输入错误，请输入一个数字。');
        else
            disp(['你输入的数值是：', num2str(inputNum2)]);
            Tri_cal_Function(inputNum2,2);
        end
end
