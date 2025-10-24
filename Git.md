#Git以及Github学习

#设置本地用户信息
  
  git config --global user.name "name"
  git config --global user.email "email"

#查看本地用户信息
  
  git config --global user.name
  git config --global user.email

#获取本地仓库
  要使用Git对我们的代码进行版本控制，首先需要获得本地仓库
  1)在电脑的任意位置创建一个空目录（例如test）作为我们的本地Git仓库
  2)进入这个目录中，点击右键打开Git bash窗口
  3)执行命令git init
  4)如果创建成功后可在文件夹下看到隐藏的.git目录

#工作区->暂存区->仓库
  git status :查看当前状态，分为提交了和没提交，如果有没提交的文集那，会显示文件状态：未跟踪、未暂存、已暂存
  git add <文件> ：对于新添加的文件和修改的文件使用git add 添加到暂存区
  git add . :添加所有到暂存区
  git commit -m '具体的注释内容' ：提交至仓库

