---
title: "できる Flycheck拡張 (shell scriptでチェッカーを実装する)"
date: 2019-04-19T08:00:00+09:00
tags: ["Emacs", "Flycheck", "Shell"]
---

[Flycheck](https://www.flycheck.org)はEmacsのデファクトスタンダードな構文チェッカーです。

以前[マイナーな言語の構文チェッカー](https://github.com/igjit/flycheck-copl)を自作しました。
Flycheckの拡張は思ったより簡単にできたので、ここでやり方を紹介しておきます。

基本的には[Developer’s Guide](https://www.flycheck.org/en/latest/developer/developing.html)に必要なことは全て書いてあるので、わからないことがあったらこちらを参照すると良いかと思います。

この記事では、より気軽に実践できるように、構文チェッカー本体をshell scriptで実装します。

## shell scriptでチェッカーを書く

例としてコード中の`TODO`コメントを警告するという(おせっかいな)チェッカーをshell scriptで実装してみましょう。

こんなshell scriptをチェックの対象とします。(`bad.sh`)

```sh
#!/bin/sh

# TODO: 引数チェック
name=$1

echo "Hello, ${name}"

# TODO: 気の利いたことを言う
echo 'Bye!'
```

試しにgrepで問題のある行を抽出してみます。

```sh
$ cat bad.sh | grep -n TODO
3:# TODO: 引数チェック
8:# TODO: 気の利いたことを言う
```

エラーメッセージっぽく整形。

```sh
$ cat bad.sh | grep -n TODO | awk -F: '{print "warning:"$1":TODO comments should be removed."}'
warning:3:TODO comments should be removed.
warning:8:TODO comments should be removed.
```

エラーのフォーマットは

```
エラーの種類:行:エラーメッセージ
```

としました。

良さそうなら以下のようなshell scriptとして保存しておきます。(`check_todo.sh`)

```sh
#!/bin/sh

cat $1 |
    grep -n TODO |
    awk -F: '{print "warning:"$1":TODO comments should be removed."}'
```

実行権限を付与

```sh
chmod +x check_todo.sh
```

Emacsの`exec-path`の通った所に置いておきます。例えば

```lisp
(add-to-list 'exec-path "~/bin")
```

と設定してあったら

```sh
cp check_todo.sh ~/bin
```

## Flycheckの設定

先程のshell scriptをFlycheckから呼び出せるようにします。

```lisp
(require 'flycheck)

(flycheck-define-checker sh-todo-checker
  "Check TODO comment"
  :command ("check_todo.sh" source)
  :error-patterns
  ((warning line-start "warning:" line ":" (message) line-end))
  :modes sh-mode)

(add-to-list 'flycheck-checkers 'sh-todo-checker)
```

`:error-patterns`でFlycheckのDSLを使ってエラーのフォーマットを指定しています。

shell scriptを開いてFlycheckを有効にすれば警告が表示されるはずです。

![](/images/posts/2019/04/flycheck-in-shell/flycheck.png)
