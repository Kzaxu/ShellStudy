#!/bin/zsh

# 变量运算
# 1. 整数运算
#   方法一：expr
echo 1 + 3
expr 1 + 3
num1=1
num2=3
expr $num1 + $num2
sum=`expr $num1 + $num2`
echo "sum is $sum"
multi=`expr $num1 \* $num2` # * 为元字符，需要转译
echo "multi is $multi"
#   方法二：$(())
sum=$((num1+num2))          #小括号内部计算不需要$
echo "sum is $sum"

sum2=$(($num1+$num2))
echo "sum2 is $sum2"

#   方法三：$[]
sum3=$[num1+num2]
echo "sum3 is $sum3"

#   方法四：let 但是这种方式要注意表达式内不能包含空格
let sum4=2+3; echo $sum4
i=0
let i++; echo $i
let sum5=sum4+sum3; echo $sum5 

# 2. 小数运算
echo "2*4" | bc 
echo "2^4" | bc 
echo "scale=2; 6/4" | bc 
awk 'BEGIN{print 1/2}'
echo "print(5.0/2)" | python
