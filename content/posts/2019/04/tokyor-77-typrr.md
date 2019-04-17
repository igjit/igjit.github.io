---
title: "Tokyo.R #77 でRの型検査を実装した話をした"
date: 2019-04-15T20:00:53+09:00
tags: ["R"]
---

[Tokyo.R #77](https://tokyor.connpass.com/event/125793/)のLTでRの型検査を実装した話をしてきました。

<div class="iframe-wrapper" style="padding-top:56.25%">
<iframe src="https://igjit.github.io/slides/2019/04/typrr/#/">
</iframe>
</div>

<https://igjit.github.io/slides/2019/04/typrr/#/>

[プログラミング言語の基礎概念](http://www.fos.kuis.kyoto-u.ac.jp/~igarashi/CoPL/index.cgi)という本に出てくる型推論のアルゴリズムをRで実装して遊んでみた、という内容です。

実装はこちら: <https://github.com/igjit/typrr>

## Emacsで動かす

当日の型検査のデモはEmacsで行いました。(RStudioで動くようにしようと思ったけど間に合わなかった)

Emacsに[ESS](https://ess.r-project.org/)と[Flycheck](https://www.flycheck.org)がインストールされていれば、[これを](https://github.com/igjit/typrr/blob/master/inst/emacs/flycheck-typrr.el)ロードすれば動くはずです。

## RStudioで動かす

後日RStudioで動くようにしました。(`rocker/tidyverse:3.5.3`で動作確認)

Consoleで以下を実行してパッケージをインストール

```r
devtools::install_github("igjit/typrr")
```

Consoleで以下のように型検査したいファイルを指定して[lintr](https://github.com/jimhester/lintr)実行

```r
lintr::lint("sample.R", list(typrr_linter = typrr::typrr_linter()))
```

すると型エラーある場合はMarkers paneにエラーの箇所が表示されます。

![](/images/posts/2019/04/tokyor-77-typrr/rstudio.png)

スライドにあるように[対応している構文が少なすぎる](https://igjit.github.io/slides/2019/04/typrr/#/27)ので実用性は無いですが、型推論の面白さの一端に触れてもらえると嬉しいです。
