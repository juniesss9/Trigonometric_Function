import sys
import subprocess
from PyQt5.QtWidgets import QApplication, QMainWindow, QWidget, QVBoxLayout, QLabel, QLineEdit, QPushButton

class MatlabGUI(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("MATLAB GUI")
        self.setGeometry(100, 100, 500, 300)

        # 创建布局
        layout = QVBoxLayout()

        # 创建输入框和标签
        self.input_label = QLabel("请输入一个角度:")
        self.input_field = QLineEdit()
        layout.addWidget(self.input_label)
        layout.addWidget(self.input_field)

        # 创建计算按钮
        self.calculate_button = QPushButton("计算")
        self.calculate_button.clicked.connect(self.calculate_results)
        layout.addWidget(self.calculate_button)

        # 创建结果显示区域
        self.sin_label = QLabel()
        self.cos_label = QLabel()
        self.arcsin_label = QLabel()
        self.arctan_label = QLabel()
        layout.addWidget(self.sin_label)
        layout.addWidget(self.cos_label)
        layout.addWidget(self.arcsin_label)
        layout.addWidget(self.arctan_label)

        # 设置主窗口的布局
        central_widget = QWidget()
        central_widget.setLayout(layout)
        self.setCentralWidget(central_widget)

    def calculate_results(self):
        # 检查 MATLAB 是否已启动
        try:
            subprocess.check_call(['matlab', '-r', 'ver', '-nodesktop', '-nosplash'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        except subprocess.CalledProcessError:
            # 如果 MATLAB 未启动,则启动 MATLAB
            subprocess.Popen(['matlab', '-nodesktop', '-nosplash'])

        # 获取用户输入的角度
        input_text = self.input_field.text()

        # 调用 MATLAB 代码
        try:
            result = subprocess.run(['matlab', '-batch', f"setenv('inputText', '{input_text}'); run('back_end.m'); exit;"], stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
            if result.returncode == 0:
                # 解析 MATLAB 输出
                lines = result.stdout.strip().split('\n')
                self.sin_label.setText(lines[0])
                self.cos_label.setText(lines[1])
                self.arcsin_label.setText(lines[2])
                self.arctan_label.setText(lines[3])
            else:
                print(f"MATLAB 执行错误: {result.stderr}")
        except subprocess.CalledProcessError as e:
            print(f"MATLAB 执行错误: {e}")

if __name__ == "__main__":
    app = QApplication(sys.argv)
    gui = MatlabGUI()
    gui.show()
    sys.exit(app.exec_())