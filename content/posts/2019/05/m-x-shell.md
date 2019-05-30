---
title: "M-x shellで常に新しいshellを起動する"
date: 2019-05-31T05:00:00+09:00
tags: ["Emacs", "Shell"]
---

Emacsの中でshellを使う方法はいくつかありますが、私は古き良き[shell-mode](https://www.gnu.org/software/emacs/manual/html_node/emacs/Shell-Mode.html)を使っています。

`M-x shell`すると、shell bufferが存在しない場合は新たにshellを起動、存在する(かつshell processが起動している)場合は既存のshell bufferを開きます。

追加でshellを起動したい場合は `C-u M-x shell`してからbuffer名を指定する必要があり、面倒だったので`M-x shell`で常に新しいshellを起動するようにしました。

```el
(defalias 'my-shell-original (symbol-function 'shell))
(defun shell ()
  (interactive)
  (my-shell-original (generate-new-buffer-name "*shell*")))
```
