#make 常用选项
#Make默认在当前目录中寻找GUNmakefile，makefile，Makefile文件作为make的输入文件
#-f 可以指定除上述文件名之外的文件作为输入文件
#-v 显示版本号
#-n 只输出命令但不执行
#-s 只执行命令，但不输出具体命令，此处可在命令中用@符抑制命令输出
#-w 显示执行前执行后的路径
#-C dir 指定makefile所在目录

#makefile 变量
#系统变量
# $^ 所有不重复依赖的变量
# $@ 目标文件的完整名称

#自定义变量
#定义: 变量名 = 变量值
#使用: $(变量名)/$(变量名)

#伪目标 .PHONY 伪目标
#声明目标为伪目标之后，makefile将不会判断该目标是否需要更新
.PHONY:show

#模式匹配 %目标:%依赖
#目标和依赖相同部分，可用%来通配
# %.o:%.c

# wildcard 获取当前目录下所有.c文件
# $(wildcard ./*.c)
# patsubst 将对应的.c文件名替换为.o文件
# $(patsubst %.c,%.o, ./*.c)
# 将上述两个函数合并 将当前目录下的所有.c文件替换为.o文件
# $(patsubst %.c,%.o, $(wildcard ./*.c))

# 动态链接库
# 动态 运行时才去加载 动态加载
# 链接 指库文件和二进制程序分离，用某种特殊手段维护两者之间的关系
# 库 库文件 .dll .so

# makefile 所有指令都是先展开所有变量，在调用变量
# =   赋值，但是用终值，就是不管变量调用写在赋值前还是复制后，调用时都是终值
# :=  也是赋值，但是只受当前行及之前代码影响，而不受后面的赋值影响

# makefile 的条件判断
#ifeq   判断是否相等，相等返回true，不相等放回false
#ifned  判断是否不相等，相等返回true，不相等放回false
#ifdef  判断变量是否存在，存在返回true，不存在返回false
#ifndef 判断变量是否不存在，不存在返回true，存在返回false

#ifeq, ifneq 与条件之间要有空格，不然会报错


TARGET = SeqList       #工程名
OBJ = $(patsubst %.c,%.o, $(wildcard ./*.c)) #替换当前目录下所有.c文件的文件名

CC = gcc               #编译器
RM = del               #删除命令 windows平台为del linux平台为 rm -rf 强制删除所有指定文件
DEL = *.exe *.o        #要删除的文件
#Linux 平台为 DEL = $(OBJ) $(wildcard ./*.exe)
#DEL = $(OBJ) $(wildcard ./*.exe)

make: clean $(TARGET)  #清除历史编译生成的文件，生成新文件
#编译文件
$(TARGET):$(OBJ)
		$(CC) $^ -o $@

%.o:%.c                        #编译为目标文件 
		$(CC) -c -g $<         

.PHONY:clean           #清除指定文件
clean:
		$(RM) $(DEL)

# 伪目标定义在上侧
show:
		echo $(wildcard ./*.c)
		echo $(patsubst %.c,%.o, $(wildcard ./*.c))
		echo $(DEBUG)

