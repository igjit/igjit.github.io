---
title: "<<-とクロージャ"
date: 2021-12-21T00:00:00+09:00
tags: ["R"]
output: hugodown::md_document
rmd_hash: 11a4736179a9f925

---

[R Advent Calendar 2021](https://qiita.com/advent-calendar/2021/rlang)の21日目の記事です。

演算子`<<-`はグローバル環境に代入する、という説明を見かけることがあります。 例えば[Rの基礎とプログラミング技法](https://www.maruzen-publishing.co.jp/item/b294191.html)には

> 演算子`"<<-"`は常に`.GlobalEnv`環境にオブジェクトを生成する．

とあります。

しかし**常に**、というのは正確ではないです。 今日は`<<-`の挙動とその使い道についてお話します。

## \<\<-の挙動

では`<<-`の挙動は？ [R言語徹底解説](https://www.kyoritsu-pub.co.jp/bookdetail/9784320123939)には以下のように書かれています。

> 通常の付値演算子`<-`は現在の環境に変数を作成する． 一方`<<-`は現在の環境ではなく，親環境をさかのぼって最初に見つかった変数を修正する．

<br>

> 変数が見つからない場合，`<<-`はグローバル環境に変数を新規に作成するが，これは望ましいことではない．

親環境をさかのぼる？親環境って何？ グローバル環境に代入するのが望ましくないなら`<<-`は何に使うの？

まずは環境について説明しましょう。

## 環境

環境は名前と値を関連付けるものです。

[`environment()`](https://rdrr.io/r/base/environment.html)は現在の環境を返します。 ユーザが普段作業をしている環境はグローバル環境です。

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nf'><a href='https://rdrr.io/r/base/environment.html'>environment</a></span><span class='o'>(</span><span class='o'>)</span>
<span class='c'>#&gt; &lt;environment: R_GlobalEnv&gt;</span></code></pre>

</div>

環境をリストに変換することで、その中身を見ることができます。

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>abc</span> <span class='o'>&lt;-</span> <span class='m'>123</span>
<span class='nf'><a href='https://rdrr.io/r/base/list.html'>as.list</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/environment.html'>environment</a></span><span class='o'>(</span><span class='o'>)</span><span class='o'>)</span>
<span class='c'>#&gt; $abc</span>
<span class='c'>#&gt; [1] 123</span></code></pre>

</div>

現在の環境にある変数`abc`が見えました。

環境は[`new.env()`](https://rdrr.io/r/base/environment.html)で作成することができます。 しかし実はRユーザは日常的に環境をたくさん作っています。関数の実行環境です。 関数を実行すると、実行するたびに新しい環境が生成されます。これを関数の**実行環境**と呼びます。

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>foo</span> <span class='o'>&lt;-</span> <span class='kr'>function</span><span class='o'>(</span><span class='o'>)</span> <span class='o'>&#123;</span>
  <span class='nf'><a href='https://rdrr.io/r/base/environment.html'>environment</a></span><span class='o'>(</span><span class='o'>)</span>
<span class='o'>&#125;</span>
<span class='nf'>foo</span><span class='o'>(</span><span class='o'>)</span>
<span class='c'>#&gt; &lt;environment: 0x55949180ab60&gt;</span>
<span class='nf'>foo</span><span class='o'>(</span><span class='o'>)</span>
<span class='c'>#&gt; &lt;environment: 0x559491958088&gt;</span></code></pre>

</div>

`foo()`を実行するたびに新しい環境が生成されています。

実行環境の中身を覗いてみましょう。

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>foo</span> <span class='o'>&lt;-</span> <span class='kr'>function</span><span class='o'>(</span><span class='nv'>a</span><span class='o'>)</span> <span class='o'>&#123;</span>
  <span class='nv'>b</span> <span class='o'>&lt;-</span> <span class='m'>456</span>
  <span class='nf'><a href='https://rdrr.io/r/base/list.html'>as.list</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/environment.html'>environment</a></span><span class='o'>(</span><span class='o'>)</span><span class='o'>)</span>
<span class='o'>&#125;</span>
<span class='nf'>foo</span><span class='o'>(</span><span class='m'>123</span><span class='o'>)</span>
<span class='c'>#&gt; $b</span>
<span class='c'>#&gt; [1] 456</span>
<span class='c'>#&gt; </span>
<span class='c'>#&gt; $a</span>
<span class='c'>#&gt; [1] 123</span></code></pre>

</div>

仮引数の`a`と関数内で代入した`b`が見えました。 (ちなみに環境内のオブジェクトに順番はありません。よってリストに変換した結果の順番に意味は無いです。)

環境には親があります。[`parent.env()`](https://rdrr.io/r/base/environment.html)で親環境を知ることができます。

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>foo</span> <span class='o'>&lt;-</span> <span class='kr'>function</span><span class='o'>(</span><span class='o'>)</span> <span class='o'>&#123;</span>
  <span class='nf'><a href='https://rdrr.io/r/base/environment.html'>parent.env</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/environment.html'>environment</a></span><span class='o'>(</span><span class='o'>)</span><span class='o'>)</span>
<span class='o'>&#125;</span>
<span class='nf'>foo</span><span class='o'>(</span><span class='o'>)</span>
<span class='c'>#&gt; &lt;environment: R_GlobalEnv&gt;</span></code></pre>

</div>

関数の実行環境は、その**関数が生成された環境**を親に持ちます。 関数`foo`はグローバル環境で生成されたので、その実行環境の親環境はグローバル環境です。

`<<-`の挙動は、親環境をさかのぼって最初に見つかった変数を修正する、というものでした。 よってグローバル環境で生成された関数内で`<<-`を使うと親環境であるグローバル環境の変数を修正します。

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>foo</span> <span class='o'>&lt;-</span> <span class='kr'>function</span><span class='o'>(</span><span class='o'>)</span> <span class='o'>&#123;</span>
  <span class='nv'>abc</span> <span class='o'>&lt;&lt;-</span> <span class='m'>234</span>
<span class='o'>&#125;</span>
<span class='nf'>foo</span><span class='o'>(</span><span class='o'>)</span>
<span class='nv'>abc</span>
<span class='c'>#&gt; [1] 234</span></code></pre>

</div>

ここまでは`<<-`はグローバル環境に代入する、という説明のとおりです。 そうではない場合もあります。見てみましょう。

## クロージャ

関数内で関数を生成してみます。その親環境はどうなるでしょう。

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>f</span> <span class='o'>&lt;-</span> <span class='kr'>function</span><span class='o'>(</span><span class='o'>)</span> <span class='o'>&#123;</span>
  <span class='nf'><a href='https://rdrr.io/r/base/print.html'>print</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/environment.html'>environment</a></span><span class='o'>(</span><span class='o'>)</span><span class='o'>)</span>
  <span class='nv'>g</span> <span class='o'>&lt;-</span> <span class='kr'>function</span><span class='o'>(</span><span class='o'>)</span> <span class='o'>&#123;</span>
    <span class='nf'><a href='https://rdrr.io/r/base/print.html'>print</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/environment.html'>parent.env</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/environment.html'>environment</a></span><span class='o'>(</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span>
  <span class='o'>&#125;</span>
  <span class='nf'>g</span><span class='o'>(</span><span class='o'>)</span>
<span class='o'>&#125;</span>
<span class='nf'>f</span><span class='o'>(</span><span class='o'>)</span>
<span class='c'>#&gt; &lt;environment: 0x559491432f68&gt;</span>
<span class='c'>#&gt; &lt;environment: 0x559491432f68&gt;</span></code></pre>

</div>

外側の関数の実行環境が、そこで生成された関数の親環境であることが確認できました。

よって内側の関数で`<<-`を使うと、親環境である外側の関数の実行環境に代入します。

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>f</span> <span class='o'>&lt;-</span> <span class='kr'>function</span><span class='o'>(</span><span class='o'>)</span> <span class='o'>&#123;</span>
  <span class='nv'>a</span> <span class='o'>&lt;-</span> <span class='m'>123</span>
  <span class='nv'>g</span> <span class='o'>&lt;-</span> <span class='kr'>function</span><span class='o'>(</span><span class='o'>)</span> <span class='o'>&#123;</span>
    <span class='nv'>a</span> <span class='o'>&lt;&lt;-</span> <span class='m'>456</span>
  <span class='o'>&#125;</span>
  <span class='nf'>g</span><span class='o'>(</span><span class='o'>)</span>
  <span class='nv'>a</span>
<span class='o'>&#125;</span>
<span class='nf'>f</span><span class='o'>(</span><span class='o'>)</span>
<span class='c'>#&gt; [1] 456</span></code></pre>

</div>

より実用的な例を挙げます。以下はカウンターを生成する関数です。

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>make_counter</span> <span class='o'>&lt;-</span> <span class='kr'>function</span><span class='o'>(</span><span class='o'>)</span> <span class='o'>&#123;</span>
  <span class='nv'>n</span> <span class='o'>&lt;-</span> <span class='m'>0</span>
  <span class='kr'>function</span><span class='o'>(</span><span class='o'>)</span> <span class='o'>&#123;</span>
    <span class='nv'>n</span> <span class='o'>&lt;&lt;-</span> <span class='nv'>n</span> <span class='o'>+</span> <span class='m'>1</span>
    <span class='nv'>n</span>
  <span class='o'>&#125;</span>
<span class='o'>&#125;</span></code></pre>

</div>

`make_counter()`によって作られた関数`count_a`は、自身が呼び出された回数を返します。

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>count_a</span> <span class='o'>&lt;-</span> <span class='nf'>make_counter</span><span class='o'>(</span><span class='o'>)</span>
<span class='nf'>count_a</span><span class='o'>(</span><span class='o'>)</span>
<span class='c'>#&gt; [1] 1</span>
<span class='nf'>count_a</span><span class='o'>(</span><span class='o'>)</span>
<span class='c'>#&gt; [1] 2</span>
<span class='nf'>count_a</span><span class='o'>(</span><span class='o'>)</span>
<span class='c'>#&gt; [1] 3</span></code></pre>

</div>

もう一つカウンターを作ってみましょう。

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>count_b</span> <span class='o'>&lt;-</span> <span class='nf'>make_counter</span><span class='o'>(</span><span class='o'>)</span>
<span class='nf'>count_b</span><span class='o'>(</span><span class='o'>)</span>
<span class='c'>#&gt; [1] 1</span>
<span class='nf'>count_b</span><span class='o'>(</span><span class='o'>)</span>
<span class='c'>#&gt; [1] 2</span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nf'>count_a</span><span class='o'>(</span><span class='o'>)</span>
<span class='c'>#&gt; [1] 4</span></code></pre>

</div>

`count_a`、`count_b`はお互い独立して数を数えることができます。 各自が生成された別々の環境を親環境として参照しているためです。 このように、自身が生成された環境を囲い込んでいる関数のことを**クロージャ**と言います。

## 参考文献

[R言語徹底解説](https://www.kyoritsu-pub.co.jp/bookdetail/9784320123939)

今回扱った環境を始め、Rの仕様の複雑な部分をHadley Wickhamがものすごく明快に解説しています。 クロージャの実用例も紹介されています。 一通り読めば、よりRの仕様に確信を持ってコードを書けるようになるはずです。 長期休暇に読むと良いかも。Enjoy!

