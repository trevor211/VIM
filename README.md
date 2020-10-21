# vim配置

## 简介

个人常用vim配置，常用开发语言：c/c++。

## 功能

-- 支持代码索引(gtags & ctags)
-- 支持lsp
-- 支持文件搜索
-- 支持函数查找
-- 等等

## 依赖

- vim8
- gtags
- nodejs
- clangd
- ccls

## 安装

git clone <https://github.com/trevor211/VIM.git>
mv VIM ~/.vim
cp ~/.vim/.vimrc ~/.vimrc
打开vim, 执行:PlugInstall

## centos7安装vim8

```
# 移除旧版本
sudo yum remove vim -y
# 安装必要组件
sudo yum install ncurses-devel python-devel -y
# 下载源码编译安装
git clone https://github.com/vim/vim.git
cd vim/src
# 根据自己实际情况设置编译参数
./configure --with-features=huge --enable-pythoninterp=yes --enable-cscope --enable-fontset --with-python-config-dir=/usr/lib64/python2.7/config --enable-python3interp=yes --with-python3-config-dir=/usr/lib64/python3.6/config-3.6m-x86_64-linux-gnu --with-python3-command=python3.6
make
sudo make install
```

## 注意

使用ccls需要先编译项目，生成索引文件：compile_commands.json，并放置在项目的根目录下。

### cmake生成索引

```
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .
```

### Makefile生成索引

先安装：[Bear](https://github.com/rizsotto/Bear)

```
make clean
bear make
```
