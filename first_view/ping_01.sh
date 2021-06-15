#!zsh

# 单行脚本，如果成功输出。。。否则。。。。
# &> 重定向输出
ping -c1 www.baidu.com &>/dev/null && echo "www.baidu.com is up" || echo "www.baidu.com is down"

# 将 <<-EOF EOF 中间的代码重定向到python中执行
python <<-EOF
print("hello world")
for i in range(3):
    print(f"hello {i} print")
EOF