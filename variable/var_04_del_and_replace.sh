#!/bin/zsh

## 变量删除与替换
url=www.baidu.com

# 从起始匹配 # 等价于 're.sub('^www.ba', "", $url)'
echo ${url#www.ba} # 删除#后面的字符串（从前往后）
echo ${url#*.}     # 从前往后删除匹配到的字符串（非贪婪）
echo ${url##*.}    # 从前往后删除匹配到的字符串（贪婪）
echo ${url#ba}     # 不能从开始匹配出 ba 所以不做删除

# 从结束匹配 %
echo ${url%com}    # 从后往前匹配 com，匹配到则删除
echo ${url%.*}     # 非贪婪
echo ${url%%.*}    # 贪婪

# 索引与切片
echo ${url:1:5}    # 等同于python 中的切片，url[1:1+5]
echo ${url:5}      # 等同于 url[5:-1]

# 内容的替换
echo ${url/baidu/sina}   # 等同于 re.sub('baidu', 'sina', url)
echo ${url//w/p}   # 替换所有

# 变量的默认值 ${变量名:-默认值} （空值替换）
var1=555
echo ${var1-abc}
echo ${var2-abc}   # 没有定义过的变量使用默认值“abc”
var3=
echo ${var3-abc}   # 只要是定义过，即便是空值也不能替代
# :- 可以替换空值
echo ${var3:-abc}
echo ${var1:-abc}


# 非空替换
echo ${var1+aaaa}  # var1 如果设定过，则替换 
echo ${var1:+aaaa} # var1 设定非空，则替换

# 空值替换并赋值
echo ${var1=aaaa}  # var1 没设定过，替换输出并赋值给 var1
echo ${var1:=aaaa} # var1 没设定过或者空值，替换输出并赋值给 var1

# 空值输出 stderr
echo ${var1?aaaa}  # var1 没设定过，输出aaaa至stderr
echo ${var1:?aaaa} 
