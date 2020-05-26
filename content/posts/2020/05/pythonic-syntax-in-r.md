---
title: "PythonのあれはRでこう書ける"
date: 2020-05-26T09:30:00+09:00
tags: ["R", "Python"]
---

[RにはないPythonの文法・テクニック (演算子/for文/条件分岐 編)](https://datascience-blog.com/2020/05/25/225006)という記事を読みました。一部の内容はRでも実現できそうなので書いておきます。

## セイウチ演算子 := (walrus operator)

セイウチ演算子はPython 3.8で導入された[代入式](https://docs.python.org/ja/3/whatsnew/3.8.html#assignment-expressions)と呼ばれる構文とのことですが、Rではもともと代入は式であり、値を返します。
なので式の一部として普通に代入演算子(`<-`)を使うことができます。

```r
> b <- (a <- 10) / 2
> c(a, b)
[1] 10  5
```

## withステートメント (with文)

後片付けのための特殊な構文は私の知る限りRにはなさそうです。

例に挙がっているファイルの読み書きは、たいていは[readr](https://readr.tidyverse.org/)をはじめとするライブラリを使えば良いので、プログラマーが直接ファイルコネクションを操作する機会はあまりないかもしれません。

ちなみに自分でファイルコネクションを扱うときは

```r
con <- file("example.txt")
on.exit(close(con))
```

みたいにしておくと閉じ忘れを防げます。

## 空のシーケンスやコレクションが真理値の偽になる

これはそのとおりで、Rでは`if`, `while`の条件に入れられるのは

> A length-one logical vector that is not NA

です。厳しいですね。

## 条件分岐での比較演算子の連結

これもRでは無理です。Pythonすごい。

## iterableなオブジェクト (反復可能なオブジェクト)

Rのfor文で回せるのは

> An expression evaluating to a vector (including a list and an expression) or to a pairlist or NULL.

とのこと。確かに文字列を1文字づつはできないですね。

## for文のenumerate

これは[purrr::imap](https://purrr.tidyverse.org/reference/imap.html)を使うとできます。

```r
> library(purrr)
> fruit <- c("apple", "orange", "lemon")
> fruit %>% imap(~ paste(.y, .x))
[[1]]
[1] "1 apple"

[[2]]
[1] "2 orange"

[[3]]
[1] "3 lemon"
```

値を返すほうが好みなので`imap`を使いましたが、表示など副作用のみが欲しい場合は`iwalk`を使うと良いです。

## 変数を利用しないfor文

何かを繰り返すときは私はこんな感じで書きます。

```r
> replicate(3, "I love you")
[1] "I love you" "I love you" "I love you"
```

表示が目的だったら

```r
> library(purrr)
> replicate(3, "I love you") %>% walk(~ cat(., "\n"))
I love you 
I love you 
I love you 
```
