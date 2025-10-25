Linux Shell 学习

    linux中的复制与粘贴：选中即可复制、按下滚轮即可粘贴
    
#命令：
    
    pwd :显示现在所在的目录

    whoami :显示当前用户名\显示以什么身份登陆

    clear :清理

    ls :list,显示当前目录所有列表

    ls -l :列表的长版本完整信息

    ls -l -a:列表显示所有文件，包括隐藏。a：代表all,这里激活了两个开关命令同样可以写成：
    ls -la:与上一个命令效果一致，简写方式。

    cd : 进入到某个文件夹

    cd ~:返回home位置

    cd .. :返回上一层

    cd ../..:返回上级的上级
    
    . :当前位置源，如果输入 cd . ：会回到当前位置。

    cat file.txt :打开txt类型的文件，查看内容

    touch README.txt: 创建一个没有内容的README.txt文件
    
    rm README.txt : 删除这README.txt文件        
    rm file_1.txt file_2.txt: 支持多文件删除
    
    nano README.txt : 使用nano（文本工具）创建并打开README.txt

    ls --help:显示出ls 后的帮助注释。也可以使用man ls。
        -l :长格式        
        -a :列出所有
        -d :列出文件夹
        -h :友好人类可读格式        
        -S :文件按照大小排列
        -R/r :无论大写还是小写，递归的方式现实所有内容（当前位置的所有文件，和文件夹内的所有文件），R顺序、r倒序
        可以随意组合：-lah、-lh、-als、
    * ：文件选择选项(通配符)
        *.txt： 选择所有txt格式文件
        m*：所有首字母为m的文件
    ? :占位符（通配符）    
    ls main.? ：列出名称为main的可能占一个位符的格式文件，例如main.c
    ls main.???:列出名称为main的占三个位符的格式文件,例如main.cpp

    man ls : 查看ls命令手册

    mkdir name :创建名为name的文件夹

    cp *.mp3 Musics/：将当前位置的所有.mp3格式的文件复制进当前位置上名为Musics的文件夹内    
    cp (文件源) (目的地)
    cp -R ：cp只能复制一层，如果想要复制整个文件夹(内含有递归的层级关系)，需要使用cp -R


    mv *.mp3 Musics/: 将当前位置的所有.mp3格式的文件移动到当前位置上名为Nusics的文件夹内
    mv (源) (目标)：目标可以是地址，也可以是新的文件名(文件名就是改名字了)   
    注意:在linux或unix中没有专门用来重命名的命令，可以通过使用mv命令，将文件(文件夹)移动到另一个文件(文件夹)的方式来达到重命名的效果 
    
    "" : 容器
    "~/Documents/Original file.txt":双引号内放置的内容可以带有空格，但是在shell中空格代表这间隔,不能有多余空格存在，会识别错误。

#不同的文件颜色，反应出文件的不同类型。
    
    蓝色：文件夹
    绿色：文件
    白色：许可证文件，Makefile、LICENSE

#Liunx将隐藏 .xxx 以点开头文件

    rmdir Musics/ ：删除Musics文件夹，只有空文件夹才起作用。
    rm -R Musics/：删除该文件夹内的：文件、文件夹、文件夹内的子项
    rm -rf Musics/:强制删除
    -f ：强制的意思



#tab键：拼写前几个字母自动补全，整个文件名

    switch 命令：这个命令的位置，例如“switch ls”，查看ls程序命令的位置在哪，一般在bin中。

#Linux/Unix 环境的目录层次结构
 
    通用标准系统根目录：大部分linux系统都按照这个文件夹格式，但是可能会略有不同。
    root/:所有都在根目录内，包括各种挂载的磁盘也是。
    |--bin：必要的用户二进制文件/程序(系统核心部分，可执行的程序命令)：shell中所使用的命令(程序)
    |--usr：同样是二进制文件，是用户实际安装的应用程序：微信、火狐浏览器等等（只读）
    |--boot：静态boot文件，包含系统启动所需的文件，启动系统所需的基本内核模块
    |--dev：设备，u盘、光盘、键盘等所有的硬件设备都被映射到此文件夹中，除了硬件设备还有虚拟设备。
    |--etc：各种配置：用户配置、初始化配置、超级用户配置、启动方式、初始化方式等配置。文件类型通常是文本文件
    |--home：普通用户子文件夹所在的地方
    |   |--usrname1
    |   |--usrname2
    |--opt：包含可选软件包，通常用于专业软件，例如不遵守标准文件系统结构的软件，通常在安装时有些东西不知道该放在哪里，就会放在这里。
    |--lib：制作各种c类程序所需要的sdl库所安装存放位置，lib并不是唯一的存放sdl库的位置。可能有特定的用户依赖的库存放于usr-lib中。
    |--root：超级用户/管理员，相交于受限的普通用户，可以做任何事情
    |--sbin：系统管理员二进制文件，root用户需要执行的程序在此
    |--var：系统生成的日志文件（可读可写）


#多种类型的shell
    
    ~ /bin/
    |--bash:一种输入输出并解释的shell（shell解释器），the bourne-again shell。打开shell默认是bash
    |--zsh:另一种新的shell,进入zsh可直接输入zsh，退出输入exit
    |--ksh：korn shell

#echo：

    回显信息，将输入的内容打印在shell上，例子：echo "Hello world" 参考print。

#环境变量：存储信息，存储内容，可以用标识符给他们贴标签。
     
      |-- $0 : shell的名称。例子：echo $0 ,显示当前使用的shell的名称
      |-- $USER : 用户名
      |-- $HOME : 用户home文件夹的全路径
      |-- $PATH : 添加程序命令的环境变量地址，例如在任何地方都可以使用nano、cp、ls。就是因为这些程序在PATH中添加了对应的环境变量，通过环境变量找到对应的可执行文件，见下

#PATH#

    PATH=$PATH:想要执行的程序的万地址   例：PATH=$PATH:~/src/raycaster/raycasting-awk,在这个地址位置下的程序：run.sh程序就可以在任何位置执行了，但是一旦重启会失去设置的环境变量，可以使用下面的rc文件添加。
    env ：可视化查看所有的环境变量    
    
    rc文件:.bashrc、.zshrc、等等。这是对应shell的rc文件。可以通过nano程序打开rc文件进行修改添加。
    可以将PATH环境变量的添加内容，加入到rc文件中，这样就不会每次重新登陆用户后，设置的环境变量失效重新设置。
    具体方法：export PATH=$PATH:~/src/raycaster/raycasting-awk   export可以在echo $PATH的导出中查看


    grep:grep <表达式> <files>,在文件中查找"表达式"内容。接受正则表达式。例子：grep "deltaTime" * :在当前所在位置查找所有内容有deltaTime的文件。命令所在位置/bin/
    grep -R "sth" <files>,文件夹中查找所有的子项和子文件夹项的文件中的含有sth的内容。

    find:根据某某方式查找文件。例子：find . -name Game.h。 在当前源位置(.)，查找name的方式(-name)，查找名为<Game.h>的文件。该命令以递归的方式查找该位置下的所有。  命令位置/usr/bin/

#shell中显示进程相关
    
    top：一个二进制应用，告诉用户这台Linux管理上所有任务和进程
    htop:更友好的视图方式，显示进程内容。 q:退出       

#打印显示：
    
    ps x:展示该用户出所有正在执行的进程
    ps ax ：展示包括系统程序在内的所有进程
    ps aux：展示所有程序信息，包括每个进程的详细信息
    ps wx：展示进程完整名称

    kill -9 进程ID :强制杀死某个进程，ID可以通过ps命令查看
    man kill：查看kill的所有-命令内容

#shell 的输入和输出
    
    > :输出重定向
    例子1：ls -l > ListOfFiles.txt 在当前位置生成一个txt文件，把输出内容放入。
    例子2：grep -R "/SDL.h" * > SDLOcurrences.txt :将当前位置的所有内容包括递归的所有子项，查找内部写有"/SDL.h"的文件，并重新定向输出到名为SDLOcurrences的新建txt文件中。
    例子3: echo "内容" > file1.txt
    >>: 在已有的文件内容后添加，如果是>会覆盖已有的内容，可使用此

    < :输入重定向
    head :输出某个文件的前几行
    head < /etc/passwd:将passwd文件定向给head，让head进行输出
    head -n1 < /etc/passwd : 将过滤只剩下1行，进行输出
    tail :输出某个文件的后几行
    
#< | >：管道命令，可以在某物的输出作为另一过程的输入中，起到连接作用。
    
    cowsay：奶牛说
    例子1:ls | cowsay   ：ls输出，cowsay输入
    例子2:echo $0 | cowsay  :echo输出，cowsay输入
    例子3:cat passwd | grep "root" :将cat所输出的所有passwd，再输入进grep中，之查找带有root这一项输出出来。 
    例子4:cat passwd | sort -r :对输出进行首字母排序，倒序
    例子5:cat passwd | wc -l :计算输出了多少行
    wc ：计算在特定文件中找到的多少个单词，-l表示行.可使用man wc查看所有wc的相关用法
    例子6:ls -l | wc -l :查看行数
    例子7:ls -l *.conf | wc -l :当前位置上conf类型的文件有多少个
    例子8:ls -l *.conf | wc -l | cowsay

    adduser name: 添加新用户

    sudo -i :以管理员身份登陆,登陆后输入whoami，管理员名称为root,exit注销
    sudo :提升用户权限，超级执行
    ^abc:正则表达式，以abc开头的文件

    login：登陆账户

#文件权限：当我们输入ls -l查看每一行的文件时，第一部分内容就是他的权限信息。
    
    例如：-rwxr--r--,第一位file type（d,l,-）d：文件夹、l:链接(类似win的快捷方式)、-：文件
     uesr group others
    -rwx   rwx   rwx   r：read可读、w：write可写、x：execute可执行

    chmod <OPTIONS> filename : chage mod修改模式、
        例1 ： chmod +w README.md :增加可写权限
        例2 ： chmod u=rwx，g=rw,o=rwx README.md : 可执行权限设置，可增加也可删除
        例3 ： chmod o=r,g=r README.md :删除权限 
        八进制模式：755:一种快捷的权限书写方式

        执行文件：./name.格式   .就是告诉Linux在当前目录中运行，某个name.格式的文件

#包管理器：Package Managers
    
    安装.deb格式文件，因为使用的是debain延伸的系统。
    sudo apt install ./文件名.格式
    sudo apt-cache search <描述、标签> ：查找搜寻你可能要找的程序包

#文本编辑器：
    
    nano
    vim
理解系统调用
   
    fork()：create a child process identical to the parent
        c程序，系统调用，请求内核复制创建一个
    
    exec(): start a program replacing the current process

    open(): open a file for reading, writing, or both

    close(): close an open file

    mkdir(): create a new directory 

    rmdir(): remove an empty directory

    getpid(): return the PID of the caller

    getppid(): return the PID of the parnt of caller
    
#子进程
    
    gcc name.c -o name :编译名字为name.c文件,然后-o输出到name的可执行文件中。

#常用的shell工具


#shell script：shell脚本

    注意：shell脚本中表达式不可以加空格，例如=号两端
    
    原理：多个shell命令放入同一个文件中，一起执行。
    .sh后缀格式文件就是shell脚本文件。
    如果是处理更复杂的内容shell就会变得更加的冗余，这时候就需要转向更合适的语言如python。但是在处理相对简单的任务时是非常有效的。
    例子：
        nano welcome.sh --创建shell脚本文件。
    内部内容：
        echo "Hello World" --双引号可当作容器，这样能够忽略掉Hello World中的空格。
        echo "Welcome to the system"
        echo "Good bey"
    保存导出后，需要用当前使用的shell来运行脚本。如：bash ./welcome.sh

#shell脚本案例1:一般的shell脚本在首行，会写调用解释器

    #!/bin/sh   #调用解释器

    #################################################
    # Display a welcome set of messages to the user #
    #################################################
    echo "Hello World" 
    echo "Welcome to the system"
    echo "Good bey"

    文件保存后退出，需要修改执行权限后才可以运行：./welcome.sh

shell脚本案例2：nano vars.sh  --创建vars脚本

    

    
    
    
    

    

        
