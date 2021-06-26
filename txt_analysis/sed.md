### sed 命令

#### sed 工作流程
流编辑器sed：不需要与人进行交互，修改文件是重点
```mermaid
graph LR
id1[文本文件<br/>this is a line]
id1-->id2(sed 模式空间 缓冲区)
id2-->id3[sed 的输出]
```

sed是一种在线的，非交互式的编辑器，它一次处理一行内容。处理时，把当前处理的行存储在临时缓冲区中。称之为模式空间pattern space。接着用sed命令处理缓冲区中的内容，处理完成后，把缓冲区的内容送往屏幕。接着处理下一行，这样不断重复，直到文件末尾。文件内容并没有改变，除非你使用重定向存储输出。

sed主要用来自动编辑一个或多个文件；简化对文件的反复操作；编写转换程序。

#### 格式命令
```shell
sed [options] 'command' file(s)
sed [options] -f scriptfile file(s)
# 注意：
# sed和grep不一样，不管是否找到指定的模式，它的退出状态都是0
# 只有当命令存在语法错误时，sed的退出状态才是非0

sed -ri bak
sed -ric --follow-symlinks
```

#### 支持正则表达式
（1）与grep一样，sed在文件中查找模式时，也可以使用正则表达式RE和各种元字符。
（2）正则表达式是括在斜杠间的模式，用于查找和替换 ，以下是sed支持的元字符
（3）使用基本元字符集：^ ，$, .，*，[],[^]，\ <\ >，\ (\ )，{ \ }
（4）使用扩展元字符集：？，+，{ }，|，( )
（5）使用扩展元字符的方式：\\+，sed -r

#### 基本用法
**参数**
- -r: 正则表达式支持扩展元字符
- -i: 编辑后的结果修改至源文件
- -n: 静默模式，不输出除了p命令外的结果
- -e: 允许多项编辑
- -f: 指定sed脚本文件名


**定址**
地址用于决定对哪些行进行编辑。地址形式可以是数字、正则表达式或者二者的结合。如果不加地址，则针对所有行。

```shell
sed -r 'd' passwd       # 删除passwd文件中所有行
sed -r '3d' passwd      # 删除passwd文件中第三行
sed -r '1,3d' passwd    # 删除passwd文件中一到三行
sed -r '5,$d' passwd    # 删除passwd文件中5行到最后

sed -r '/root/d' passwd   # 删除包含root的行
sed -r '/root/!d' passwd   # 删除不包含root的行
sed -r '\#root#d' passwd  # 删除包含root的行
sed -r '/root/,5d' passwd   # 从root行开始，删除到第5行（包含root）

sed -r 's/root/alice/g' passwd  # 查找root换成alice 
sed -r '/^adm/,20d' passwd      # 删除以adm开头的，删到第20行
sed -r '/^adm/,+20d' passwd     # 删除以adm开头的，再删除后面20行
sed -r '2,5d' passwd            # 删除第2到5行

sed -r '1~2d' passwd            # 删除所有奇数行 从1开始每隔两行删除
sed -r '0~2d' passwd            # 删除所有偶数行
```

**命令**
- a 在当前行后添加一行或多行
- p 打印
- d 删除
- i 在当前行之前插入文本
- ! 对所选行以外的所有行应用命令
- r 从所选文件读，写入位置
- w 将行写入文件
- /match/cmd 查找包含match的行后执行cmd命令
  - 查找范围不一定要使用 "/" 进行包含，可以使用容易字符进行包含，但该字符需要先转译，例如 `\#match#`
- s/origin/sub/ 将查找到的 origin 替换为 sub，origin 支持正则表达式
  - g 行内全局替换，例如`s/origin/sub/g`
  - i 忽略大小写
  - 和上面一样，不一定需要使用 "/" 进行包含，例如 `s#origin#sub#` 无需转译


#### 命令示例

**删除命令: w**
```shell
sed -r '3d' datafile
sed -r '3{d;}' datafile         # 有可能同一行有多个命令，命令间用; 隔开
sed -r '3,$d' datafile
sed -r '$d' datafile            # 删除最后一行

sed -r '/sout/d' datafile       # 删除含sout的行
```

**替换命令: s**
```shell
sed -r %s/root/\#&/g             # & 表示查找串匹配到的内容，将所有root前面加#
sed -r 's#3#88#g' datafile       # 将行中的 3 换成 88
```

**读文件指令: r**
```shell
sed -r '/lp/r /etc/hosts' datafile
sed -r '2r /etc/hosts' datafile          # 在第二行处插入文件内容
sed -r '/2/r /etc/hosts' datafile        # 在匹配到 2 后，插入文件内容
```

**写文件命令: w**
```shell
sed -r '/root/w newfile' datafile        # 匹配到root的行写入到新文件
sed -r '3,5w newfile' datafile           # 3到5行写入到新文件
```

**追加命令: a**
```shell
sed -r '/root/a1111111' datafile         # 匹配到root后追加1111111
sed -r '2a1111111' datafile              # 第二行后面追加1111111
```

**插入命令: i**
```shell
sed -r '/root/i1111111' datafile         # 匹配到root在前面添加1111111
sed -r '2i1111111' datafile              # 第二行最前面追加1111111
```

**修改命令: c**
```shell
sed -r '/root/c1111111' datafile         # 匹配到root的行整个替换为1111111
sed -r '2c1111111' datafile              # 第二行整个替换为1111111
```

**获取下一行: n**
```shell
sed -r '/eastern/{n;d}' datafile              # 匹配到eastern后，删除下一行
sed -r '/eastern/{n;s/AM/Archile}' datafile
```

**暂存和取用**
暂存空间天然有一个\n

- -h: 将模式空间放到暂存空间（覆盖）
- -H: 将模式空间放到暂存空间（追加）
- -g: 从暂存空间取出所有行，并覆盖定址行（模式空间）
- -G: 从暂存空间取出所有行，并覆追加址行（模式空间）

```shell
sed -r '1h;$G' /etc/hosts               # 最后一行后面追加第一行（第一行并没有删除）
sed -r '1{h;d};$G' /etc/hosts           # 最后一行后面追加第一行（第一行删除）
sed -r '1h; 2,$g' /etc/hosts            # 第一行元素覆盖第二行和最后一行
sed -r '1h; 2,3H; $G' /etc/hosts        # 将1，2，3行追加到最后一行
```

**暂存空间和模式空间互换命令: x**
```shell
sed -r '4h; 5x; 6G' /etc/hosts          # 第四行覆盖到第五行，并将第五行追加到第六行
```

**反向选择: !**
```shell
sed -r '3d' datafile
sed -r '3!d' datafile                   # 除了第三行都删除
```

