---
title: "「プログラミング言語の基礎概念」のために作ったEmacs拡張"
date: 2019-04-22T08:19:00+09:00
draft: true
tags: ["Emacs", "CoPL"]
---

「[プログラミング言語の基礎概念](http://www.saiensu.co.jp/?page=book_details&ISBN=ISBN978-4-7819-1285-1)」の演習問題を解くためのEmacs拡張を作ったので紹介します。

## 動機

[出版社のページ](http://www.saiensu.co.jp/?page=book_details&ISBN=ISBN978-4-7819-1285-1)に

> 関数型言語MLの一種Objective Camlを題材としてプログラミング言語の意味論，型システム，プログラミング言語の基礎概念，これらの概念間の数学的な関連を学ぶ．オンライン演習システムを用いて，「証明」を解答とする演習問題の正誤をWeb上で自動判定することもできる．

とあるとおり、この本にはオンライン演習システムが用意されていて、演習問題の採点をしてもらえます。

![](/images/posts/2019/04/emacs-lisp-for-copl/cgi.png)

採点によって自分の理解度を確認できてとても便利なのですが、長い導出をエディタの補助なしに完成させるのは大変です。

なのでEmacsの

- major-mode
- Flycheck拡張

を作りました。

## major-mode

[igjit/copl-mode](https://github.com/igjit/copl-mode)

シンタックスハイライトを実装しました。

![](/images/posts/2019/04/emacs-lisp-for-copl/copl-mode.png)

一応、波括弧 `{}` のインデントに対応していますが実装は超手抜きです。

## Flycheck拡張

[igjit/flycheck-copl](https://github.com/igjit/flycheck-copl)

Flycheckで導出が正しいかチェックできるようにしました。

![](/images/posts/2019/04/emacs-lisp-for-copl/flycheck.png)

導出のチェックは著者の五十嵐先生が公開されている[copl-tools](https://github.com/aigarashi/copl-tools)をdockerで動かしています。([igjit/docker-copl-tools](https://github.com/igjit/docker-copl-tools))

## 所感

Emacsで割と快適に演習問題を解くことができるようになりました。

得られた知見:

<blockquote class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr">CoPLの演習問題、詳細の導出は &quot;?&quot; で後回しにして幅優先で解いたほうが良さそう。<br>深さ優先で導出すると最後の方で間違いに気付いたりする…… <a href="https://t.co/D8lz8u8zkE">pic.twitter.com/D8lz8u8zkE</a></p>&mdash; igjit (@igjit) <a href="https://twitter.com/igjit/status/1061978730736738304?ref_src=twsrc%5Etfw">2018年11月12日</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
