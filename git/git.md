### 拆分子目录为独立仓库

     git clone git@github.com:xingxing9688/system.git 
     cd system 
     把所有"abc" 目录下的相关提交整理为一个新的分支 a
     git subtree split -P abc -b a

    另外一个新目录并初始化为git 仓库
    mdkir ../a
    cd../a
    git init 

    拉取仓库的a分支到当前的master 分支
    git pull ../system a  
   
    接下来推送给新的远端仓库
    git   remote  add  origin   git://github.com/a.git 
    git push origin master 
    以上是保持了历史记录

    清楚一个子目录下所有内容和记录
     git clone git@github.com:xingxing9688/systemc.git 
     cd system

     清理 `master` 分支上所有跟 `abc` 目录有关的痕迹
     git filter-branch --index-filter "git rm -rf --cached --ignore-unmatch abc" --prune-empty master

     另建一个新目录并初始化为 git 仓库
     mkdir ../a-fresh
     cd ../a-fresh
     git init

     拉取 `big-project` 的 `master` 分支（到新仓库的 master 分支）
     git pull ../abc master




