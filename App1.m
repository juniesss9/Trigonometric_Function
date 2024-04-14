classdef App1 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        Cal                   matlab.ui.Figure                   % 三角函数计算器
        LabelNumericEditField matlab.ui.control.Label            % 输入α
        Input                 matlab.ui.control.NumericEditField % [-Inf Inf]
        Label                 matlab.ui.control.Label            % 三角函数计算器
        Readme                matlab.ui.control.TextArea         % 使用说明：
        ButtonGroup           matlab.ui.container.ButtonGroup    % 功能选择
        RadioButton           matlab.ui.control.RadioButton      % 1
        RadioButton2          matlab.ui.control.RadioButton      % 2
        LabelEditField        matlab.ui.control.Label            % sin α
        Output1               matlab.ui.control.EditField       
        Label2                matlab.ui.control.Label            % cos α
        Output2               matlab.ui.control.EditField       
        Button                matlab.ui.control.Button           % 计算
        Warning               matlab.ui.control.EditField       
    end


    properties (Access = public)
        mode % 计算功能选择： 1.sin cos 2.arcsin arctan
    end

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.mode = '1'; %默认计算功能
            app.Warning.Value = '输入提示';
        end

        % ButtonGroup selection change function
        function ButtonGroupSelectionChanged(app, event)
            selectedButton = app.ButtonGroup.SelectedObject;
            app.mode = selectedButton.Text;
            switch app.mode
                case'1'   %输出为sin和cos
                    app.LabelEditField.Text = 'sin α';
                    app.Label2.Text = 'cos α';
                case'2'   %输出为arcsin和arctan
                    app.LabelEditField.Text = 'arctan α';
                    app.Label2.Text = 'arcsin α';                   
            end 
        end

        % Button button pushed function
        function ButtonButtonPushed(app)
            %输入
            x = app.Input.Value;
            %计算三角函数并弹出可能的预警
             [app.Output1.Value,app.Output2.Value,warn2,warn1]=Tri_cal_Function(x,str2double(app.mode));     
             app.Warning.Value = [warn2,warn1];
        end
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create Cal
            app.Cal = uifigure;
            app.Cal.Position = [100 100 631 428];
            app.Cal.Name = '三角函数计算器';
            setAutoResize(app, app.Cal, false)

            % Create LabelNumericEditField
            app.LabelNumericEditField = uilabel(app.Cal);
            app.LabelNumericEditField.BackgroundColor = [0.9373 0.9373 0.9373];
            app.LabelNumericEditField.HorizontalAlignment = 'center';
            app.LabelNumericEditField.VerticalAlignment = 'center';
            app.LabelNumericEditField.FontSize = 16;
            app.LabelNumericEditField.FontWeight = 'bold';
            app.LabelNumericEditField.Position = [349 211 43 20];
            app.LabelNumericEditField.Text = '输入α';

            % Create Input
            app.Input = uieditfield(app.Cal, 'numeric');
            app.Input.FontSize = 16;
            app.Input.Position = [410 211 62 20];

            % Create Label
            app.Label = uilabel(app.Cal);
            app.Label.BackgroundColor = [0.9255 0.6941 0.102];
            app.Label.HorizontalAlignment = 'center';
            app.Label.VerticalAlignment = 'center';
            app.Label.FontName = '等线';
            app.Label.FontSize = 24;
            app.Label.FontWeight = 'bold';
            app.Label.Position = [292 427 233 59];
            app.Label.Text = '三角函数计算器';

            % Create Readme
            app.Readme = uitextarea(app.Cal);
            app.Readme.FontSize = 14;
            app.Readme.FontColor = [1 0 0];
            app.Readme.Position = [213 339 394 74];
            app.Readme.Value = {'使用说明：'; '请在“功能选择”栏选择“1”（可计算sin α和cos α）或“2”（可计算arcsin α和arctan α），在“输入α”栏输入需计算的对象。最后点击“计算”按钮，即可得到对应的计算结果。'};

            % Create ButtonGroup
            app.ButtonGroup = uibuttongroup(app.Cal);
            app.ButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @ButtonGroupSelectionChanged, true);
            app.ButtonGroup.BorderType = 'line';
            app.ButtonGroup.TitlePosition = 'centertop';
            app.ButtonGroup.Title = '功能选择';
            app.ButtonGroup.FontName = 'Helvetica';
            app.ButtonGroup.FontWeight = 'bold';
            app.ButtonGroup.FontUnits = 'pixels';
            app.ButtonGroup.FontSize = 16;
            app.ButtonGroup.Units = 'pixels';
            app.ButtonGroup.Position = [359 246 103 81];

            % Create RadioButton
            app.RadioButton = uiradiobutton(app.ButtonGroup);
            app.RadioButton.Text = '1';
            app.RadioButton.Position = [10 29 26 16];
            app.RadioButton.Value = true;

            % Create RadioButton2
            app.RadioButton2 = uiradiobutton(app.ButtonGroup);
            app.RadioButton2.Text = '2';
            app.RadioButton2.Position = [10 7 26 16];

            % Create LabelEditField
            app.LabelEditField = uilabel(app.Cal);
            app.LabelEditField.HorizontalAlignment = 'right';
            app.LabelEditField.FontSize = 16;
            app.LabelEditField.FontWeight = 'bold';
            app.LabelEditField.Position = [12 104 70 20];
            app.LabelEditField.Text = 'sin α';

            % Create Output1
            app.Output1 = uieditfield(app.Cal, 'text');
            app.Output1.FontWeight = 'bold';
            app.Output1.Position = [93 96 683 36];

            % Create Label2
            app.Label2 = uilabel(app.Cal);
            app.Label2.HorizontalAlignment = 'right';
            app.Label2.FontSize = 16;
            app.Label2.FontWeight = 'bold';
            app.Label2.Position = [10 55 72 20];
            app.Label2.Text = 'cos α';

            % Create Output2
            app.Output2 = uieditfield(app.Cal, 'text');
            app.Output2.FontWeight = 'bold';
            app.Output2.Position = [93 47 683 37];

            % Create Button
            app.Button = uibutton(app.Cal, 'push');
            app.Button.ButtonPushedFcn = createCallbackFcn(app, @ButtonButtonPushed);
            app.Button.BackgroundColor = [0.902 0.2235 0.2235];
            app.Button.FontName = '等线';
            app.Button.FontSize = 16;
            app.Button.FontWeight = 'bold';
            app.Button.Position = [352 158 118 34];
            app.Button.Text = '计算';

            % Create Warning
            app.Warning = uieditfield(app.Cal, 'text');
            app.Warning.HorizontalAlignment = 'center';
            app.Warning.FontName = '新宋体';
            app.Warning.FontColor = [1 0 0];
            app.Warning.BackgroundColor = [0.9373 0.9373 0.9373];
            app.Warning.Position = [153 133 523 20];
        end
    end

    methods (Access = public)

        % Construct app
        function app = App1()

            % Create and configure components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.Cal)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.Cal)
        end
    end
end