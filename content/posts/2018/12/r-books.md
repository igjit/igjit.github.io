---
title: "プログラマーのためのRの参考書"
date: 2018-12-11T06:40:11+09:00
tags: ["R"]
---

[R Advent Calendar 2018](https://qiita.com/advent-calendar/2018/rlang)の11日目の記事です。

同僚(非Rユーザーのプログラマー)に、Rの良い本を教えてほしいと言われたので、私が良いと思うRの本を挙げていきます。

他の言語のプログラマーがRの言語仕様を把握し、Rで書かれたコードを理解したいケースを想定しています。

## 入門書

### [RStudioではじめるRプログラミング入門](https://www.oreilly.co.jp/books/9784873117157/)

良い入門書だと思います。

序文に

> 人は、読むことではなく、することによって学習するのである。

とあります。この本はまさにリファレンスではなく、手を動かしながら学ぶチュートリアルって感じですね。

著者がRの言語仕様を良く理解した上で、明快に解説している感があって良いです。

ベクトル化コード、クロージャを使った変数のカプセル化、ジェネリック関数によるオブジェクトシステムなどは、それらに触れるのが初めての人には読み応えがあると思います。

原著は[webで公開されています](https://rstudio-education.github.io/hopr/)。

## 言語仕様

### [R言語徹底解説](https://www.kyoritsu-pub.co.jp/bookdetail/9784320123939)

私が今まで読んだ中で最高のRの本です。R界の神、Hadley WickhamがRの難解な仕様をまさに徹底解説しています。

関数型プログラミング、非標準評価、DSL、コードの最適化など、興味深い話題もたくさんあります。

> Rはかなり癖のある言語なので時にイライラさせられるが、それでもRが本質的にはエレガントで美しい言語であり、データ分析や統計処理を実行するのに適した工夫に満ちていることを、本書を通じて示したい。

原著は[webで公開されています](https://adv-r.hadley.nz/)。

## パッケージ

### [Rではじめるデータサイエンス](https://www.oreilly.co.jp/books/9784873118147/)

Rの魅力は(癖がありながらも)強力な言語仕様と、それに支えられた便利なパッケージ群でしょう。多くのwebプログラマーがRailsのためにRubyを書くように、多くの分析者はtidyverseでデータ分析するためにRを書きます。

この本はtidyverseのパッケージ群を使ってデータ分析を行う方法を作者本人が解説しています。

- [パイプ演算子 (%>%)](https://adv-r.hadley.nz/functions.html#function-composition)
- dplyr
  - [Data transformation](https://r4ds.had.co.nz/transform.html)
  - [Relational data](https://r4ds.had.co.nz/relational-data.html)
- [リスト処理](https://r4ds.had.co.nz/iteration.html#the-map-functions)

など、実務で必要なところを拾い読みするだけでも良いと思います。

原著は[webで公開されています](https://r4ds.had.co.nz/)。
