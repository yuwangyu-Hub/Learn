# Picotron的笔记

## 按键输入
我们都知道在pico-8中有两种检测按键输入的方式：btn() 和 btnp() 
这两个都是进行输入某一值的检测，然后返回true或false。
但是在pico-8中还存在另一种输入检测方式，就是获取btn()的值。

这里和之前的区别在于之前的使用需要btn(a),将要检测的按键a输入，而如果我们运行如下代码，会在当我们进行输入的时候返回一个值。
```lua
function _draw()
    print(btn()) 
end
```

大家可能第一时间联想到输出的值，应该是对应了按键输入的值，但是却不是。
输出的值是：将六个输入按键排列为二进制格式，按下为1，无按下为0，然后输出为十进制的值。
 X  O  ⬆️ ⬇️ ⬅️ ➡️
 0  0  0  0  0  0 = 0
知道了这个之后，可以找出所有的值和对应的按钮
L:left \ R:right \ U:up \ D:down
O \ X


0 - 无按下 
1 - L 
2 - R 
3 - L+R 
4 - U 
5 - L+U 
6 - R+U 
7 - L+U+R 
8 - D 
9 - L+D 
10 - R+D 
11 - L+D+R 
12 - U+D 
13 - L+U+D 
14 - R+U+D 
15 -U+D+L+R全部按下 
16 - O 
17 -O+L 
18 -O+R 
19 -O+L+R 
20 -O+U 
21 -O+L+U 
22 -O+R+U 
23 -O+L+R+U 
24 -O+D 
25 -O+L+D 
26 -O+R+D 
27 -O+L+R+D 
28 -O+U+D 
29 -O+U+D+L 
30 -O+U+D+R 
31 -O+L+R+U+D 
32 -X 
33 -X+L 
34 -X+R 
35 -X+L+R 
36 -X+D 
37 -X+L+D 
38 -X+R+D 
39 -X+L+R+U 
40 -X+D 
41 -X+D+L 
42 -X+D+R 
43 -X+D+L+R 
44 -X+U+D 
45 -X+U+D+L 
46 -X+U+D+R 
47 -X+U+D+L+R 
48 -O+X 
49 -O+X+L 
50 -O+X+R 
51 -O+X+L+R 
52 -O+X+U 
53 -O+X+U+L 
54 -O+X+U+R 
55 -O+X+U+L+R 
56 -O+X+D 
57 -O+X+D+L 
58 -O+X+D+R 
59 -O+X+D+L+R 
60 -O+X+U+D 
61 -O+X+U+D+L 
62 -O+X+U+D+R 
63 -O+X+U+D+L+R 
64 -menu 

要注意：这里只展示了pico-8的64个组合输出显示，picotron目前版本也只支持这些按键的组合输出。

所以 》= 64 都说明在按住其他键的同时，按下了menu按键。可以直接识别为menu按下

可以通过添加“与或”值的方式，进行遮罩。
只检测方向 
local btnv = btn()&0b1111

使用：按位与（&）进行运算
二进制0b1111，所以会剔除掉x和o按键输入

![alt text](Image/input.png)

## piccotron中的输出字体设置

```lua
    --\014是小字体的控制符，\015是大字体的控制符
    print("\014playgame",x,y,c)
    print("\015exitgame",x,y,c)
```
只是部分，还有其他很多。

## picotron中的多地图多图层的地图tile编号获取

在picotron中mget只能作为0.map这张地图的第一层获取。限制在了单一地图的设置。
如果想要获取到多地图的某一层需要：
```lua
    my_map = fetch("map/1.map") -- 加载你的地图
    -- 读取 图层0 的 (5,5)
    id = my_map[1].bmp:get(5, 5)
```


