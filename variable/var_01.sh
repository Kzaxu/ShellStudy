#!zsh

# 通过键盘给变量赋值
printf "please enter your name: " 
read name
echo "hello ${name}!"

if [ "$name" = "xu" ]; then 
    echo "hello owner"
else
    echo "hello guest"
fi

# 直接给变量赋值
var1=123
echo "var1 is: ${var1}"

# 通过参数给变量赋值(位置变量)
# 例如 zsh ./var_01.sh arg1 arg2 ...
# 则有 $1=arg1, $2=arg2
echo "first arg is ${1}"