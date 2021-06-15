#!/bin/zsh

# case 基本语法结构
# case 语句是有顺序的 
test01() {
    printf "who are you: "
    read user
    case "$user" in 
    "xuxu")
        echo "hello owner"
        ;;
    "root")
        echo "hello root"
        ;;
    *)
        echo "not know you"
        ;;
    esac
}


while true
do
    echo -n "what you want?(1/2)"
    read choose
    case "$choose" in
    1) 
        clear
        test01;;
    "")
        ;;
    *)
        break;;
esac
done
echo "finish..."