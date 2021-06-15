#!/bin/zsh

# 条件测试
# 1. 文件测试
# 表达式 test, test 条件表达式
dir_name=`dirname $0`
if ! test -d $dir_name; then
    echo "不是一个目录"
else
    echo "是一个目录"
fi

# [ 表达式 ] 等价于 test 表达式 ] 为 [ 的参数，所以一定要有空格
if [ ! -d `basename $0` ]; then
    echo "不是一个目录"
else
    echo "是一个目录"
fi

# if 语句后可以接如何命令，接受的是语句的返回值
user=xuxu
if id $user &>/dev/null; then
    echo "该用户存在"
else
    echo "该用户不存在"
fi

# 2. 数值比较
if [ $UID -ne 0 ]; then
    echo "当前用户不是root用户"
fi

# c 语言风格的数值比较 (())
((1 > 5 || 2 < 3)); echo $?
# 不能用来做字符串比较，例如
name=xuxu
(($name = jojo)); echo $?
# 变量可以省略$
var=123
((var > 1000 && var <1000)); echo $?


# 3. 字符串比较
# hint: 使用"" 包含要比较的变量，遇到字符串变量最好使用 "" 包含

[ "$USER" = "root" ]; echo $?
[ "$username" = "root" ]; echo $?
# [ $username = "root" ]; echo $? 不加 "" 遇到未定义变量会报错
BBB=""
[ -z $BBB ]; echo $? 
[ -z "$BBB" ]; echo $? 
[ -n $BBB ]; echo $? # 不加 "" 此时结果出错
[ -n "$BBB" ]; echo $? # 不加 "" 此时出错

# 可以使用 -a（and） 或者 -o（or） 连接多个表达式
[ 1 -lt 2 -a 5 -gt 10 ]; echo $?
[ 1 -lt 2 -o 5 -gt 10 ]; echo $?

# [[]] 中使用 && || 代替 -a -o
[[ 1 -lt 2 || 5 -gt 10 ]]; echo $?
[[ 1 -lt 2 && 5 -gt 10 ]]; echo $?

# 单个 [] 不支持正则表达式，需要使用 [[]]
num1=1234
num2=12abc
[[ "$num1" =~ ^[0-9]+$ ]]; echo $?
[[ "$num2" =~ ^[0-9]+$ ]]; echo $?

