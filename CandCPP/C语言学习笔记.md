# C语言

​	本书为C语言学习的笔记整理。

## 一、基础

### 1. C语言语法知识

```c
Int main() //main 表示一个主函数
{
	//主函数返回值
	return 0；//return 表示函数返回值
}
```

返回值类型  函数名(输入参数值)

{

​	函数内部实现;

​	return 函数返回值;

}

### 2. 关键字

C语言中的所有关键字

| auto    | _Bool    | break  | case      |
| ------- | -------- | ------ | --------- |
| char    | _Complex | const  | continue  |
| default | restrict | do     | double    |
| else    | enum     | extern | float     |
| for     | goto     | if     | Imaginary |
| inline  | int      | long   | register  |
| return  | short    | signed | sizeof    |
| static  | struct   | switch | typedef   |
| union   | unsigned | void   | volatile  |
| while   |          |        |           |

## 二、数据类型

​	C语言中数据类型有整型、浮点型、布尔类型、字符串类型、

### 1.整型

下面罗列了所有整数数据类型

| 类型名称 | c语言中的关键词 | 注释                       |
| -------- | --------------- | -------------------------- |
| 字符型   | char            | 用于表示一个很小的整数     |
| 短整型   | short           | 用于表示一个不怎么大的整数 |
| 整型     | int             | 生活中一般的整数都可表示   |
| 长整型   | long            | 用于表示一个较大的整数     |
| 加长整型 | long long       | 用于表示一个非常大的整数   |

2.