---
title: "SuuntoのGPSウォッチのデータをYAMAPにインポートする"
date: 2020-11-22T00:00:00+09:00
tags: ["GPS"]
---

私は山の行動記録にSuuntoのGPSウォッチを使っています。
このデータをYAMAPで共有できると便利なので方法を紹介します。

スマートフォンのSuunto AppからFITファイルをダウンロード

<img src="/images/posts/2020/11/suunto-yamap/ss-download-fit.png" width="50%">


PCで[GPSBabel](https://www.gpsbabel.org/)を使ってFITファイルをGPXフォーマットに変換。

UbuntuにGPSBabelをインストール

```sh
sudo apt install gpsbabel
```

Macの場合は

```sh
brew install gpsbabel
```

GPSBabelの使い方は

```sh
gpsbabel -i INTYPE -o OUTTYPE INFILE OUTFILE
```

なのでFITをGPXに変換するには

```sh
gpsbabel -i garmin_fit -o gpx infile.fit outfile.gpx
```

あとは[別のサービスでとった軌跡から日記を作るには？ ](https://help.yamap.com/hc/ja/articles/900000967783-%E5%88%A5%E3%81%AE%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E3%81%A7%E3%81%A8%E3%81%A3%E3%81%9F%E8%BB%8C%E8%B7%A1%E3%81%8B%E3%82%89%E6%97%A5%E8%A8%98%E3%82%92%E4%BD%9C%E3%82%8B%E3%81%AB%E3%81%AF-)の通りにGPXファイルをYAMAPにアップロード

活動日記の編集画面で地図を指定するとチェックポイントが表示されるようになります。
