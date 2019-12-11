---
title: "Rの参照オブジェクト"
date: 2019-12-11T09:00:00+09:00
tags: ["R"]
---

[R Advent Calendar 2019](https://qiita.com/advent-calendar/2019/rlang)の11日目の記事です。

Rのオブジェクトを関数に渡して変更したい場合はどうしましょう。

例えば渡された`x`の要素`n`に1を足す関数を定義して

``` r
increase <- function(x) {
  x$n <- x$n + 1
}
```

listを渡して呼び出した場合

``` r
l <- list()
l$n <- 10
increase(l)
l$n
```

``` r
## [1] 10
```

listの中身は変わりません。

Rは関数型プログラミングを推奨する言語であり、関数は引数を直接変更しないようになっているためです。

こういうときは参照オブジェクトを使います。例えばRの環境は参照オブジェクトです。

新しい環境を生成

``` r
e <- new.env(parent = emptyenv())
```

環境に値をセットして`increase`に渡すと

``` r
e$n <- 10
increase(e)
e$n
```

``` r
## [1] 11
```

値が変更されました。

環境のほかに、参照クラスのオブジェクトも参照オブジェクトです。

``` r
Counter <- setRefClass("Counter", fields = "n")

cnt <- Counter$new()
cnt$n <- 10
increase(cnt)
cnt$n
```

``` r
## [1] 11
```

値が変更されました。

ただしオブジェクトのフィールドを外部から直接操作するのはカプセル化OOPの流儀から外れています。値を増やす操作はクラスのメソッドとして実装しましょう。

``` r
Counter <- setRefClass("Counter",
                       fields = "n",
                       methods = list(
                         increase = function() n <<- n + 1
                       ))

cnt <- Counter$new(n = 10)
cnt$increase()
cnt$n
```

``` r
## [1] 11
```

関数に渡して変更することもできます。

``` r
increase_it <- function(x) x$increase()
increase_it(cnt)
cnt$n
```

``` r
## [1] 12
```

ちなみに参照オブジェクトかどうかは以下のように調べることができます。

``` r
is(cnt, "refObject")
```

``` r
## [1] TRUE
```

## 参考文献

[プロフェッショナル R―関数型プログラミング，オブジェクト指向，他言語インターフェースによる拡張―](https://www.kyoritsu-pub.co.jp/bookdetail/9784320124486)

Rをどのように使うかを書いた本はたくさんありますが、この本はRが何のために生まれ、なぜそのような仕様になっているのかをRの主要開発者のJohn Chambers氏が詳細に語っている稀有な良書です。Rの言語仕様に興味がある人は長期休暇に読むと良いかも。Enjoy!
