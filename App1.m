classdef App1 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        Cal                   matlab.ui.Figure                   % ���Ǻ���������
        LabelNumericEditField matlab.ui.control.Label            % �����
        Input                 matlab.ui.control.NumericEditField % [-Inf Inf]
        Label                 matlab.ui.control.Label            % ���Ǻ���������
        Readme                matlab.ui.control.TextArea         % ʹ��˵����
        ButtonGroup           matlab.ui.container.ButtonGroup    % ����ѡ��
        RadioButton           matlab.ui.control.RadioButton      % 1
        RadioButton2          matlab.ui.control.RadioButton      % 2
        LabelEditField        matlab.ui.control.Label            % sin ��
        Output1               matlab.ui.control.EditField       
        Label2                matlab.ui.control.Label            % cos ��
        Output2               matlab.ui.control.EditField       
        Button                matlab.ui.control.Button           % ����
        Warning               matlab.ui.control.EditField       
    end


    properties (Access = public)
        mode % ���㹦��ѡ�� 1.sin cos 2.arcsin arctan
    end

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.mode = '1'; %Ĭ�ϼ��㹦��
            app.Warning.Value = '������ʾ';
        end

        % ButtonGroup selection change function
        function ButtonGroupSelectionChanged(app, event)
            selectedButton = app.ButtonGroup.SelectedObject;
            app.mode = selectedButton.Text;
            switch app.mode
                case'1'   %���Ϊsin��cos
                    app.LabelEditField.Text = 'sin ��';
                    app.Label2.Text = 'cos ��';
                case'2'   %���Ϊarcsin��arctan
                    app.LabelEditField.Text = 'arctan ��';
                    app.Label2.Text = 'arcsin ��';                   
            end 
        end

        % Button button pushed function
        function ButtonButtonPushed(app)
            %����
            x = app.Input.Value;
            %�������Ǻ������������ܵ�Ԥ��
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
            app.Cal.Name = '���Ǻ���������';
            setAutoResize(app, app.Cal, false)

            % Create LabelNumericEditField
            app.LabelNumericEditField = uilabel(app.Cal);
            app.LabelNumericEditField.BackgroundColor = [0.9373 0.9373 0.9373];
            app.LabelNumericEditField.HorizontalAlignment = 'center';
            app.LabelNumericEditField.VerticalAlignment = 'center';
            app.LabelNumericEditField.FontSize = 16;
            app.LabelNumericEditField.FontWeight = 'bold';
            app.LabelNumericEditField.Position = [349 211 43 20];
            app.LabelNumericEditField.Text = '�����';

            % Create Input
            app.Input = uieditfield(app.Cal, 'numeric');
            app.Input.FontSize = 16;
            app.Input.Position = [410 211 62 20];

            % Create Label
            app.Label = uilabel(app.Cal);
            app.Label.BackgroundColor = [0.9255 0.6941 0.102];
            app.Label.HorizontalAlignment = 'center';
            app.Label.VerticalAlignment = 'center';
            app.Label.FontName = '����';
            app.Label.FontSize = 24;
            app.Label.FontWeight = 'bold';
            app.Label.Position = [292 427 233 59];
            app.Label.Text = '���Ǻ���������';

            % Create Readme
            app.Readme = uitextarea(app.Cal);
            app.Readme.FontSize = 14;
            app.Readme.FontColor = [1 0 0];
            app.Readme.Position = [213 339 394 74];
            app.Readme.Value = {'ʹ��˵����'; '���ڡ�����ѡ����ѡ��1�����ɼ���sin ����cos ������2�����ɼ���arcsin ����arctan �������ڡ�������������������Ķ�������������㡱��ť�����ɵõ���Ӧ�ļ�������'};

            % Create ButtonGroup
            app.ButtonGroup = uibuttongroup(app.Cal);
            app.ButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @ButtonGroupSelectionChanged, true);
            app.ButtonGroup.BorderType = 'line';
            app.ButtonGroup.TitlePosition = 'centertop';
            app.ButtonGroup.Title = '����ѡ��';
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
            app.LabelEditField.Text = 'sin ��';

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
            app.Label2.Text = 'cos ��';

            % Create Output2
            app.Output2 = uieditfield(app.Cal, 'text');
            app.Output2.FontWeight = 'bold';
            app.Output2.Position = [93 47 683 37];

            % Create Button
            app.Button = uibutton(app.Cal, 'push');
            app.Button.ButtonPushedFcn = createCallbackFcn(app, @ButtonButtonPushed);
            app.Button.BackgroundColor = [0.902 0.2235 0.2235];
            app.Button.FontName = '����';
            app.Button.FontSize = 16;
            app.Button.FontWeight = 'bold';
            app.Button.Position = [352 158 118 34];
            app.Button.Text = '����';

            % Create Warning
            app.Warning = uieditfield(app.Cal, 'text');
            app.Warning.HorizontalAlignment = 'center';
            app.Warning.FontName = '������';
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