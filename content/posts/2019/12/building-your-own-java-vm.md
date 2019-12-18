---
title: "Java VM 自作 方法"
date: 2019-12-19T07:00:00+09:00
tags: ["R", "Java"]
---

Java VMを自作したのでその方法を書いておきます。

## 作ったもの

RでJava VMを実装しました。[igjit/jvmrr](https://github.com/igjit/jvmrr)

今のところ39個のJava VM命令を実装しており、Fizz Buzzが動きます。

[Japan.R 2019](https://japanr.connpass.com/event/154070/)での発表資料

<div class="iframe-wrapper" style="padding-top:56.25%">
<iframe src="https://igjit.github.io/slides/2019/12/jvmrr/#/"></iframe>
</div>

<https://igjit.github.io/slides/2019/12/jvmrr/#/>

## 方法

### 1. 実装言語を決める

> To implement the Java Virtual Machine correctly, you need only be able to read the class file format and correctly perform the operations specified therein.
>
> https://docs.oracle.com/javase/specs/jvms/se11/html/jvms-2.html

クラスファイルを読めてその中の命令を実行できればJava VMを実装できるよ、とのことなので好きな言語で実装しましょう。

クラスファイルはバイナリなのでバイナリを扱う方法を確認しておきます。
Rの場合は[readBin](https://stat.ethz.ch/R-manual/R-patched/library/base/html/readBin.html)でバイナリを読んで[bitw系の関数](https://stat.ethz.ch/R-manual/R-patched/library/base/html/bitwise.html)でビット操作できます。

### 2. 概要を把握する

[めもりー](https://twitter.com/m3m0r7)さんの資料がわかりやすいです。

- [PHP で JVM に入門する - 予備知識編 -](https://speakerdeck.com/memory1994/phperkaigi-2019)
- [PHP で JVM を実装して Hello World を出力するまで](https://speakerdeck.com/memory1994/php-de-jvm-woshi-zhuang-site-hello-world-wochu-li-surumade)

### 3. Hello Worldを動かす

[Java VM仕様](https://docs.oracle.com/javase/specs/jvms/se11/html/index.html)を確認しつつ実装していきます。
わかんないとこあっても[PHP で JVM を実装して Hello World を出力するまで](https://speakerdeck.com/memory1994/php-de-jvm-woshi-zhuang-site-hello-world-wochu-li-surumade)を写経していけば多分なんとかなるはず。

Hello Worldまでが一番大変だと思うけど、Hello Worldが動くとまさにHello Worldって感じなのでがんばってください。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Rで書いたJava VMでhello world動いた。<br>今までやったhello worldの中で一番感動した。 <a href="https://t.co/9nU4p1gRKK">pic.twitter.com/9nU4p1gRKK</a></p>&mdash; igjit (@igjit) <a href="https://twitter.com/igjit/status/1186543937906806785?ref_src=twsrc%5Etfw">October 22, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

### 4. VM命令を増やす

[VM命令](https://docs.oracle.com/javase/specs/jvms/se11/html/jvms-6.html#jvms-6.5)を実装していくとできることが増えるので面白いです。私は

- 四則演算
- forループ
- Fizz Buzz

を順に実行できるようにしていきました。

```sh
javap -c FizzBuzz.class
```

とかやると実行に必要なVM命令がわかります。

## なぜ

Japan.Rの懇親会でなんでそんなことしたのって聞かれたんですが、理由はRでできるか試してみたかったのと、ただ単純に言語処理系を作るのは面白いからです。

Java VM作成は大変楽しい作業なのでみなさんも長期休暇に挑戦してみてください。Enjoy!
