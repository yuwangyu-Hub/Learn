#Git以及Github学习

    linux中的复制与粘贴：选中即可复制、按下滚轮即可粘贴

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

#工作区->暂存区->仓库(本地仓库)
  
    git status :查看当前状态，分为提交了和没提交，如果有没提交的文集那，会显示文件状态：未跟踪、未暂存、已暂存
    git add <文件> ：对于新添加的文件和修改的文件使用git add 添加到暂存区
    git add . :添加所有到暂存区
    git commit -m "具体的注释内容" ：提交至仓库
    git log :查看提交记录
    --all 显示所有分支
    --pretty=oneline 将提交信息显示为一行
    --abbrev-commit 使得输出的commit id更简短
    --graph 以图形显示
    可以通过在.bashrc（如果没有需要创建）中添加alias命令，来简化log输出的复杂写法：
    alias git-log='git log --pretty=oneline --all --graph --abbrev-cmomit'
    相当于git-log替换了原有复杂写法，这样输入git-log就可以得到后面复杂写法的同样效果。

#版本回退

    git reset --hard commitID :commitID 可以通过git log指令查看
    git reflog :这个指令可以看到已经删除的提交记录

#git忽略的文件

    一般我们总会有些文件无需纳入git的管理，也不希望它们总出现在未跟踪文件列表。通常都是些自动生成的文件，比如日志文件，或者编译过程中创建的临时文件等。在这种情况下，我们可以在工作目录中创建一个名为.gitignore的文件(文件名固定)，列出要忽略的文件模式。
    添加名为 .gitignore 的文件。在文件中把不想要git管理的文件写入即可。
    案例：#为shell中的注释
    # no .a files
    *.a
    # but do track lib.a, even though you`re ignoring .a files above,但是需要跟踪lib.a，尽管你上面忽略了所有.a文件。就是除了lib.a的意思
    !lib.a
    # only ignore the TODO file in the current directory, not subdir/TODO
    /TODO
    # ignore all files in the build/ directory
    build/
    # ignore doc/notes.txt,but not doc/server/arch.txt
    doc/*.txt
    # ignore all .pdf files in the doc/ directory
    doc/**/*.pdf

#分支

    git branch ：查看本地分支，也可以用git-log(上面设置过的)
    git branch name :创建新的分支
    git checkout name :切换分支
    还可以直接切换到一个不存在的分支(创建并切换)：git checkout -b name
    HEAD-> HEAD指向谁，谁就是的当前分支

#合并分支：将b分支合并到a分支上，首先要先切换到a分支

    git merge b ：将b分支合并到当前所在的分支上(a)

    git branch -d name :删除分支，删除时需要做各种检查，不能删除当前所在的分支，只能删除其他分支。
    git branch -D name :强制删除分支，不需要做检查
    
    解决冲突：
    





    
  
  
