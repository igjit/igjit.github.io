---
title: "Tokyo.R #79 でRでRAW現像する話をした"
date: 2019-06-30T11:00:00+09:00
tags: ["R"]
---

[Tokyo.R #79](https://tokyor.connpass.com/event/135622/)のLTでRでRAW現像する話をしてきました。

<div class="iframe-wrapper" style="padding-top:56.25%">
<iframe src="https://igjit.github.io/slides/2019/06/raw-processing-r/#/">
</iframe>
</div>

https://igjit.github.io/slides/2019/06/raw-processing-r/#/

- Moiz氏の本: [PythonとColabでできる - ゼロから作るRAW現像](https://moiz.booth.pm/items/1307327)
- 私がRで挑戦中のGitBook: [Rでできる - ゼロから作るRAW現像](https://igjit.github.io/camera-raw-processing-r/)

の紹介です。

スライドにある通りGitBookはまだ書きかけで今後更新していく予定です。

## RAW画像ライブラリについて

懇親会で「Pythonへの依存は避けられなかったのか」という旨の質問がありました。

Pythonを使った理由は、[rawpy](https://pypi.org/project/rawpy/)相当のRのパッケージが見つからなかったからです。

rawpyは[LibRaw](https://www.libraw.org/)というライブラリのPythonラッパーなので、LibRawをラップするRパッケージを作るという手もありましたが、時間が無かったのと[reticulate](https://rstudio.github.io/reticulate/) + rawpyで問題なかったのでやりませんでした。

reticulate今回初めて使ったんですが便利ですね。
