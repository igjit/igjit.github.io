---
title: "Emacsでconflrを使う"
date: 2019-02-15T07:52:43+09:00
tags: ["Emacs", "R"]
---

先日、R MarkdownをConfluenceに投稿するためのRパッケージ、[conflr](https://github.com/line/conflr)が公開されました。

[conflr: R MarkdownをConfluenceに投稿するRパッケージ](https://engineering.linecorp.com/ja/blog/conflr-published/)

最高！こんなの欲しかった！これでコンフルに分析結果を投稿するときに手でコードをコピペしてプロットのpngを該当箇所にdrag & dropし続けるという非生産的な作業から開放されますね！

## Rコンソールから使う

前述の記事ではRStudioから使う方法が紹介されているんですが、もちろんRコンソールからも使うことができます。

`~/.Renviron`に必要な環境変数を書いておいて

```
CONFLUENCE_URL=https://confluence.example.com
CONFLUENCE_USERNAME=your_name
CONFLUENCE_PASSWORD=xxx
```

Rコンソールで実行

```r
conflr::confl_create_post_from_Rmd("path/to/file.Rmd")
```

するとknitが実行されてブラウザでプレビュー画面が開きます。良さげだったらPublishボタンで投稿。

## Emacsから使う

世の中のRユーザーの99%はRStudioを使ってると思うんですが、私は[Emacs](https://www.gnu.org/software/emacs/) + [ESS](https://ess.r-project.org/)でRを書いています。
Emacsに慣れているならESSは良いと思います。(RStudioの唯一の競合はESSだ、って[Hadleyも言ってる！](http://r-pkgs.had.co.nz/intro.html))

なのでEmacsから投稿できるようにします。

前述の通り `~/.Renviron`に必要な環境変数を書いておきます。

こんな感じの関数を定義して

```lisp
(defun ess-R-confl-post-current-buffer ()
  (interactive)
  (let ((ess-dialect "R"))
    (ess-eval-linewise
     (format "conflr::confl_create_post_from_Rmd('%s')"
             (buffer-file-name)))))
```

任意のR Markdownファイルを開いて `M-x ess-R-confl-post-current-buffer`

![](/images/posts/2019/02/emacs-conflr/emacs.png)

するとknitが実行されてブラウザでプレビュー画面が開きます。

![](/images/posts/2019/02/emacs-conflr/preview.png)
