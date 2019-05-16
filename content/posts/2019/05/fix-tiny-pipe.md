---
title: "パイプ演算子自作入門のその後"
date: 2019-05-16T21:00:00+09:00
tags: ["R"]
---

[以前のTokyo.R](https://atnd.org/events/93829)でお話した[パイプ演算子自作入門](https://igjit.github.io/slides/2018/01/tiny_pipe/#/)ですが、

<div class="iframe-wrapper" style="padding-top:56.25%">
<iframe src="https://igjit.github.io/slides/2018/01/tiny_pipe/#/58">
</iframe>
</div>

`%pipe3%`のバグレポートを頂きました。Thanks [atusy](https://twitter.com/Atsushi776)!

<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">あーほんとだ<br>右辺が関数名だと動かないですね😇<br>ありがとうございます!</p>&mdash; igjit (@igjit) <a href="https://twitter.com/igjit/status/1128336965932204034?ref_src=twsrc%5Etfw">May 14, 2019</a></blockquote>

以下の[atusy](https://twitter.com/Atsushi776)による最短のpipeのように、右辺の表現式がsymbolのケースを考慮する必要があります。

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">v2 thx <a href="https://twitter.com/igjit?ref_src=twsrc%5Etfw">@igjit</a> for bug report<br><br>`%&gt;%` = function(lhs, rhs) {<br> r = substitute(rhs)<br> . = lhs<br> if (is.symbol(r)) return(rhs(.))<br> a = as.list(r[-1])<br> .q = quote(.)<br> if (any(a == .q)) return(eval(r))<br> eval(<a href="https://t.co/GI0WkPxHkF">https://t.co/GI0WkPxHkF</a>(c(r[[1]], .q, a)))<br>}</p>&mdash; atusy (@Atsushi776) <a href="https://twitter.com/Atsushi776/status/1128427827454328832?ref_src=twsrc%5Etfw">May 14, 2019</a></blockquote>

tweetに収まるpipe実装、素敵ですね。
