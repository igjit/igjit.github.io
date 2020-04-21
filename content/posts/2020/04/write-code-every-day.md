---
title: "Write Code Every Dayを1年続けた"
date: 2020-04-21T08:00:00+09:00
thumbnail: /images/posts/2020/04/write-code-every-day/ss-contributions.png
---

Write Code Every Dayを1年続けたのでその様子を記録しておきます。

Write Code Every Dayは[John Resigが始めた](https://johnresig.com/blog/write-code-every-day/)、毎日コードを書く取り組みです。
彼が決めたルールでは、ブログ記事を書くことやリファクタリングはコードを書いたことに含めないのですが、私はもっとゆるく、GitHubのpublic repositoryにpushすれば何でもokということにしました。

## やったこと

続けるに当たって気を付けたことを書いていきます。

### 面白そうなことをやる

[Java VM](/posts/2019/12/building-your-own-java-vm/)、[RAW現像](https://igjit.github.io/camera-raw-processing-r/)、[型検査](/posts/2019/04/tokyor-77-typrr/)など、自分が面白そうと思ったことに取り組みました。
ある程度複雑なプロジェクトでも、毎日やるならなんとかなりそうに思えるし、逆にしばらくコードを書くねたに困らなくなるのでおすすめです。

### 登壇する

趣味のプロジェクトは締切がなく、だらけてしまいがちなので、適宜登壇の予定を入れてLT駆動開発をしました。

この1年の登壇:

- [初めてのmajor-mode](https://igjit.github.io/slides/2019/05/major-mode/#/) ([東京Emacs勉強会 端午の節句](https://tokyo-emacs.connpass.com/event/128038/) LT)
- [初めてのRメタプログラミング](https://igjit.github.io/slides/2019/05/metaprogramming-r/#/) ([Sendai.R #1](https://sendair.connpass.com/event/123977/) 応用セッション)
- [Rでできる - ゼロから作るRAW現像](https://igjit.github.io/slides/2019/06/raw-processing-r/#/) ([Tokyo.R #79](https://tokyor.connpass.com/event/135622/) LT)
- [Shinyで作る写真編集アプリ](https://igjit.github.io/slides/2019/09/shinyroom/#/) ([Tokyo.R #81](https://tokyor.connpass.com/event/141318/) LT)
- [Rで書くJava VM](https://igjit.github.io/slides/2019/12/jvmrr/#/) ([Japan.R 2019](https://japanr.connpass.com/event/154070/) LT)
- [Schemeをknitする](https://igjit.github.io/slides/2020/01/knitscm/#/) ([Tokyo.R #83](https://tokyor.connpass.com/event/161709/) LT)

私は[発表資料](https://github.com/igjit/slides)をMarkdownで書いてgitで管理しているので、スライドを公開することでもGitHubに草が生えます。

### 写経する

技術書とかチュートリアルの写経も全部git pushします。私は[写経専用のrepository](https://github.com/igjit/sandbox)を作っていて、気軽に写経を始められるようにしています。
写経はコードを書くねたが思いつかないときにもできるので良いです。

また、[Scheme手習い](https://www.ohmsha.co.jp/book/9784274068263/)を写経するために、[Schemeのknit engine](https://github.com/igjit/knitscm)を作る、といった副産物が生まれたりもしました。

## 感想

ある程度続けると、毎日コード書いたり勉強したりするのが習慣になります。なので無理して頑張った感じはあまりありませんでした。
本当に時間がない日はほんの数行の写経で済ませることもありましたが、それでも少しづつでも続けることに意味はあると思っています。
全体的に見ると始める前より明らかにコードを書く量が増えたので。

今後も無理ない範囲で続けたいと思います。
