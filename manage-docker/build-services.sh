#! /bin/bash


(
    cd hexo
    sudo docker rmi hexo-yr:latest
    sudo docker build -t hexo-yr:latest .
    # mkdir ../../hexo
    # sudo docker run --rm -v ../../hexo:/blog hexo-yr hexo init
    # sudo docker run --rm -v ../../hexo:/blog hexo-yr npm install
    # sudo docker run --rm -v ../../hexo:/blog hexo-yr npm install hexo-theme-redefine@latest
    # sudo docker run --rm -v ../../hexo:/blog hexo-yr npm install hexo-all-minifier
    # sudo docker run --rm -v ../../hexo:/blog hexo-yr npm install hexo-filter-mathjax
    # sudo docker run --rm -v ../../hexo:/blog hexo-yr npm install hexo-filter-mermaid-diagrams
    # sudo chmod 777 -R ../../hexo
    # sudo docker run --rm -v ../../hexo:/blog hexo-yr hexo clean
    # sudo docker run --rm -p 30000:4000 -v ../../hexo:/blog hexo-yr hexo server --host 0.0.0.0
)

