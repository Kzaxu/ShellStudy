#!/bin/zsh

# 通过参数给变量赋值(位置变量)
# 例如 zsh ./var_01.sh arg1 arg2 ...
# 则有 $1=arg1, $2=arg2
echo "your name is ${1}"

# 自定义变量，作用范围仅限于当前shell
 ( ip1=3.3.3.3 )
 echo "ip1: ${ip1}"

 ip2=4.4.4.4
 ( echo "ip2: ${ip2}" )

# 环境变量可以作用于当前shell 以及子shell，通常没有必要定义环境变量
echo "begin to define env variable"
export ip2=4.4.4.4
( echo "ip2: ${ip2}" )
unset ip2 
echo "ip2: ${ip2}"


# source 表示在当前shell 中执行脚本，所以变量可以使用
source ./tem_var.sh
echo "var1 is: ${var1}"


# 预定义变量
echo "\$0 脚本路径: ${0}，文件名: `basename $0`" # basename，获取basename，dirname，获取dirname
echo "\$* or \$@ 所有的参数: $*"
echo "\$# 参数的个数: $#"
echo "\$\$ 当前进程pid: $$"
echo "\$! 上一个后台进程pid: $!"
echo "\$? 上一个命令的返回值，0表示成功: $?"

# 变量的赋值
# 以下几种都是字符串！
var1=9000 # 字符串
var2="hong kong" # 字符串中包含空格则使用引号包含
# `` 和 $() 等价，并且优先执行
today1=`date +%F` # 命令执行的结果赋值给变量 
today2=$(date +%F) # 接受命令的结果作为变量

# 强引用‘’和弱引用
echo "现在是弱引用，想要现实变量var1: $var1"
echo '现在是强引用，想要现实变量var1: $var1'

