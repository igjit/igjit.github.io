---
title: "pandocで生成するreveal.jsスライドにTwiter Cardを追加する"
date: 2019-04-20T08:00:00+09:00
tags: ["Presentation", "pandoc"]
---

pandocで生成するreveal.jsスライドに[Twiter Card](https://developer.twitter.com/en/docs/tweets/optimize-with-cards/overview/summary)を追加します。

[スライドのURL](https://igjit.github.io/slides/2018/12/nrc/#/)がこんな感じに表示されるようになります。

![](/images/posts/2019/04/reveal-twiter-card/card.png)

2つの方法を試しました。

## 1. スライドごとにタグを追加する

pandocの[reveal.jsテンプレート](https://github.com/jgm/pandoc/blob/fb1f76ddee89114a0cd1be2b2ec0c3abbad80dca/data/templates/default.revealjs#L56)に`header-includes`という変数が用意されています。

なのでこんな感じでスライドのYAMLメタデータブロックに書けば`head`内にタグが追加されます。

```md
---
header-includes:
    - <meta name="twitter:card" content="summary" />
    - <meta name="twitter:title" content="サンプルスライド" />
    - <meta name="twitter:image" content="https://farm6.staticflickr.com/5510/14338202952_93595258ff_z.jpg" />
---

スライドの内容...
```

## 2. テンプレートをカスタマイズする

上記の方法は手軽ですが、スライドを作るたびに同じ内容を書かなければならなくて面倒です。
その場合はpandocのテンプレートをカスタマイズします。

デフォルトのテンプレートをファイルに吐く

```sh
pandoc --print-default-template revealjs > template.html
```

テンプレートにmetaタグを追記

```html
  <meta name="twitter:card" content="summary" />
  <meta name="twitter:title" content="$pagetitle$" />
$if(meta-image)$
  <meta name="twitter:image" content="$meta-image$" />
$endif$
```

スライドのYAMLメタデータブロック

```md
---
pagetitle: サンプルスライド
title: |
    サンプル \
    スライド
---

スライドの内容...
```

`pagetitle` は`<title>`と`twitter:card`属性、`title`はスライドのタイトルになります。(ややこしい)

スライド出力時にテンプレートを指定

```sh
pandoc -s -t revealjs --template=template.html -o index.html index.md
```

Makefileで出力する例: https://github.com/igjit/slides/commit/ffbbb5bfbbf5b51fe101868837527b0698aa3d64

## デバッグ

うまく表示されない場合は[Card validator](https://cards-dev.twitter.com/validator)で確認します。

![](/images/posts/2019/04/reveal-twiter-card/validator.png)
