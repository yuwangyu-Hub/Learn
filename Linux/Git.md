# Git以及Github学习

    linux中的复制与粘贴：选中即可复制、按下滚轮即可粘贴

# 设置本地用户信息
	git config --global user.name "yuwangyu"
    git config --global user.email "email"

# 查看本地用户信息

    git config --global user.name
    git config --global user.email
    git config --global --list

# 获取/创建本地仓库

    要使用Git对我们的代码进行版本控制，首先需要获得本地仓库
    1)在电脑的任意位置创建一个空目录（例如test）作为我们的本地Git仓库
    2)进入这个目录中，点击右键打开Git bash窗口
    3)执行命令：git init，如果git init name，后指定名称：在当前文件夹下创建新name文件夹作为仓库
    4)如果创建成功后可在文件夹下看到隐藏的.git目录

# 工作区->暂存区->仓库(本地仓库)
  
    git status :查看当前状态，分为提交了和没提交，如果有没提交的文集那，会显示文件状态：未跟踪、未暂存、已暂存
    
    git status -s ；查看当前状态的简略模式。
    
    git add <文件> ：对于新添加的文件和修改的文件使用git add 添加到暂存区
    
    git add . :添加所有到暂存区
    
    git commit -m "注释内容" ：提交至仓库，单引号或双引号都可以，注意该命令只会提交暂存区的文件，也就是说如果文件没有git add，那这个文件是不会被git commit提交的。
    
    git commit -a -m "注释内容" ：一个命令两个动作：提交和暂存，add+commit。当然新建的文件不行，只有已经被追踪的才行。也可以省略写：git commit -am "注释内容"
    
    git log :查看提交记录
    --all 显示所有分支
    --pretty=oneline 将提交信息显示为一行
    --abbrev-commit 使得输出的commit id更简短
    --graph 以图形显示
    
    可以通过在.bashrc（如果没有需要创建）中添加alias命令，来简化log输出的复杂写法：
    alias git-log='git log --pretty=oneline --all --graph --abbrev-cmomit'
    相当于git-log替换了原有复杂写法，这样输入git-log就可以得到后面复杂写法的同样效果。

    Untrack    Unmodified    Modified      Staged
    未跟踪        未修改        已修改         已暂存

    ls ：普通的ls查看工作区内容
    git ls-files ：查看暂存区内容

# git diff ： 查看版本差异

    git diff:   1.查看文件在工作区、暂存区以及版本库之间的差异  
                2.查看文件在两个特定版本之间的差异  
                3.文件在两个分支之间的差异
    git diff ：默认比较的是工作区和暂存区之间的差异内容，会显示发生更改的文件以及更改的详细信息.当提交后工作区和暂存区内容相同，git diff就没有内容了
    git diff HEAD ：比较工作区和版本库之间的差异
    git diff --cached : 比较暂存区和版本库之间的差异
    git diff 版本ID1 版本ID2 : 比较两个特定版本之间的差异
    git diff 其他版本ID HEAD ：HEAD来表示当前分支的最新提交，HEAD指向分支的最新提交节点,比较其他版本与当前版本的差异
    git diff HEAD~ HEAD :比较前一个版本(HEAD~表示)和当前版本的差异
    git diff HEAD^ HEAD :与上一个命令一样。比较当前版本与前一个版本的差异
    git diff HEAD~2 HEAD ： 表示之前2个版本和当前版本的差异    

# 版本回退

    git reset --hard commitID :硬的,表示回退到某个版本，丢弃掉工作区和暂存区的所有内容。
              --soft commitID :软的,表示回退到某个版本，保存工作区和暂存区所有内容。
              --mixed commitID :混合的，表示回退到某个版本，只保留工作区的内容，丢弃暂存区的内容。如故不添加后缀，默认就是mixed
    commitID 可以通过git log指令查看

    一般可使用soft，这样虽然回退了，但是你在工作区和暂存区的内容还在，谨慎使用hard。
    
    git reflog :这个指令可以看到已经删除的提交记录/操作的历史记录


# 删除文件

    rm 文件名.格式 ：删除文件，这里的rm并不是git的命令，并且只是删除了工作区的文件，暂存区的文件并没有被删除，所以还需要git add 文件名.格式/git add .来告诉git暂存区的文件也删除。注意理解git add并不是添加内容，而是添加信息(这个信息可以是增加，也可以是删除）
    git rm 文件名.格式 ：直接同时删除工作区和暂存区的文件。
    git rm --cached 文件名.格式 ：只删除版本库中的文件，工作区和暂存区的不动
    最后还应该要commit提交

# git忽略的文件：.gitignore

    一般我们总会有些文件无需纳入git的管理，也不希望它们总出现在未跟踪文件列表。通常都是些自动生成的文件，比如日志文件，或者编译过程中创建的临时文件等。在这种情况下，我们可以在工作目录中创建一个名为.gitignore的文件(文件名固定)，列出要忽略的文件模式。
    添加名为 .gitignore 的文件。在文件中把不想要git管理的文件写入即可。
    添加忽略文件夹：文件夹名/   文件夹的格式要以/结尾才行
    可以这么写：echo 不想要管理的文件 > .gitignore :既创建了.gitignore 又将其定向写入
    再git status 就无法看到该文件

    注意.gitignore 无法对已经添加到版本仓库的文件产生影响

    git无法将空文件夹添加到版本控制中
    
    案例：#:shell中的注释，仅适用于.gitignore
    # no .a files，忽略所有的.a文件
    *.a
    # but do track lib.a, even though you`re ignoring .a files above,在上一条基础上，但是需要跟踪lib.a，尽管你上面忽略了所有.a文件。就是除了lib.a的意思
    !lib.a    表示取反
    # only ignore the TODO file in the current directory, not subdir/TODO，只忽略当前目录下的TODO文件，而不忽略subdir/TUDO (子目录下的TODO)
    /TODO
    # ignore all files in the build/ directory，忽略任何目录下名为build的文件夹
    build/
    # ignore doc/notes.txt,but not doc/server/arch.txt ，忽略 doc文件夹下所有的以txt格式的文件, 但不忽略子目录下的以txt结尾的文件。
    doc/*.txt
    # ignore all .pdf files in the doc/ directory,忽略 doc/目录及其所有子目录下的 .pdf文件
    doc/**/*.pdf

# 分支

    git branch ：查看本地分支，也可以用git-log(上面设置过的)
        *main : 前面带*说明当前处在的分支位置，main/master分支也是默认分支
    git branch name :创建新的分支
    git switch name :切换分支
    还可以直接切换到一个不存在的分支(创建并切换)：git switch -b name
    HEAD-> HEAD指向谁，谁就是的当前分支

    git branch -r :查看远程仓库中的所有分支
	--切换本地分支到远程某个分支上
    git switch -c dev origin/dev : dev-新建本地分支  origin/dev:远程要切换的分支。-c :create
|             命令               |                       作用                                            |
| ------------------------------ | --------------------------------------------------------------------- |
| `git switch dev`               | **切换到已有**的本地分支 `dev`                                        |
| `git switch -c dev`            | **新建并切换**到本地分支 `dev`（不指定起点，默认从当前 HEAD 创建）    |
| `git switch -c dev origin/dev` | **新建并切换**到本地分支 `dev`，同时让它**跟踪**远程分支 `origin/dev` |
    *旧的写法：git checkout -b dev origin/dev*

# 合并分支：将b分支合并到a分支上，首先要先切换到a分支

    git merge b ：将b分支合并到当前所在的分支上(a)，分支被合并后还存在，需要手动删除

    git rebase brance-name :

    git log --graph --oneline --decorate --all :查看分支图,同上用法：git-log

    git branch -d name :删除分支，删除时需要做各种检查，不能删除当前所在的分支，只能删除其他分支。
    git branch -D name :强制删除分支，不需要做检查，当你在分支上做的修改，还没有合并到主线上，-d删除会提示你没有合并不让删，这时候用-D即可


    
# 解决冲突：当两个分支上对文件的修改可能会存在冲突，例如同时修改了同一个文件的同一行，这时就需要手动解决冲突，解决冲突的步骤如下：
        
        1.处理文件中冲突的地方，打开文件手动解决。：cat 文件、然后用编辑器打开文件，并且修改保存、再cat查看修改
        2. 将解决完冲突的文件加入暂存区(add)
        3. 提交到仓库(commit)
        4. 提交后会自动合并

        如果想终止合并，使用：git merge --abort/--quit 终止合并

# 开发中分支使用原则和流程
    
    几乎所有的版本控制系统都以某种形式支持分支。使用分支意味着你可以把你的工作从开发主线上分离开来进行重大bug的修改、开发新的功能，以免影响开发主线。
    
    在开发中，一般有如下分支使用原则和流程：
        `master （生产）分支：线上分支，主分支，中小规模项目作为线上运行的应用对应的分支

        `develop（开发）分支：是从master创建的分支，一般作为开发部门的主要开发分支，如果没有其他并行开发不同期上线要求，都可以在此版本进行开发，阶段开发完成后，需要合并到master分支，准备上线。

        `feature/xxxx分支：从develop创建的分支，一般是同期并行开发，但不同期上线时创建的分支，分支上的研发任务完成后合并到develop分支。

        `hotfix/xxxx分支：从master派生的分支，一般作为线上bug修复使用，修复完成后需要合并到master、test、develop分支。

        `还有一些其他分支，在此不再详述，例如test分支（用于代码测试）、pre分支（预上线分支）等等。

# Git远程仓库：把远程仓库github内容关联到本地，远程有，本地空

    配置ssh密钥：
        1.  回到根目录 cd ~ 或者 cd
        2.  cd .ssh 进入.ssh目录
        3.  ssh-keygen -t rsa -b 4096 :使用这个命令生成密钥，-t 指定协议为rsa  -b 指定密钥大小为4096
        4. 显示信息：Enter file in which to save the key(/Users/**/.ssh/id_rsa)  第一次创建密钥可以回车，不用修改默认文件名。如果之前已经配置了ssh密钥，不要回车，回车会覆盖掉之前的密钥文件），所以要输入一个新的名字 后 再回车
        5.  输入密钥密码 再回车
        6.  ls -l 查看本地目录，找到刚才创建的密钥：两个文件（命名的文件，命名的文件.pub）命名的文件没有任何扩展名，是私钥文件。以pub格式结尾的是公钥文件。vi 打开 pub格式文件，复制密钥内容。
        7.  打开github用户头像下setting--SSH and GPG keys--new SSH key--复制密钥并写title添加
    如果第一次创建SSH密钥，并且没有修改过默认的文件名。SSH密钥的配置这里就完成了。
    如果不是第一次创建，指定了新的文件名，还需要增加一步配置：
        1. 创建config文件
        2. 把下面五行内容添加进：
            # github
            Host github.com
            HostName github.com
            PreferredAuthentications publickey
            IdentityFile ~/.ssh/修改的文件名
        配置文件的意思：当我们访问github.com的时候，指定使用SSH下的修改的文件名的这个密钥

    最后在回到本地仓库位置，执行：git clone github上SSH地址    把远程仓库克隆到本地
    在输入刚刚设置好的密码

    git push :推送
    git pull :拉取


# Git远程仓库：把本地已有的内容关联到github上，本地有，远程空

	1. 在github上创建新的远程仓库
	2. 复制远程仓库的SSH链接地址
	3. 终端进入需要上传的本地仓库位置
	4. 输入：git remote add origin 地址
		一般新创建好的空的远程仓库，在第二个说明（...or push an existing repository from the command line）中有。
	5. git remote -v 
		查看当前仓库所对应的远程仓库的别名和地址
	6. git brance -M main 
		指定分区的名称为main，因为默认的分支名称就是main，所以这一行可以省略
	7. git push -u origin main:main
		把本地的main分支和远程origin仓库的main分支关联起来,前面的main是本地仓库分支，后一个main是远程仓库分支，如果本地仓库名称与远程仓库名称相同后面的:main可以省略，-u：upstream的缩写
	8. 远程仓库页面刷新

#push 推送到远程仓库


#pull 拉取到本地仓库

# VScode的使用
	在仓库位置打开终端，输入code. :使用vscode打开当前目录
    状态说明:
    U(Untracked) :未跟踪
    M(Modified)   :已修改
    A(Added)      :已添加暂存
    D(Deleted)    :已删除
    R(Renamed)    :重命名
    和我们使用git status命令看到的结果是一样的。
