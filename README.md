# WrapScriptForX264onffmpeg
This is VBScripts for encoding with x264 of ffmpeg.  
ffmpegでx264エンコードするためのVBScriptです。  

## 特徴
`main.wsf`にファイルをD&Dするとエンコードを開始します。batファイルと違いファイル名に`! & % ...`などがあっても問題が生じません。  

エンコーダーは`libx264`を使います。30fps以下のソース映像を24fpsへエンコードする事を主目的にしています。インターレースはプログレッシブに変換されます。detelecineも行います。
出力映像の解像度から自動的に`crf`値を決定します。
~~~
    crf = a * log(width * height) / log(10) + b
~~~
`a`および`b`は定数です。オプションでcrf値を指定する事もできます。

出力映像の縦解像度を指定できます。  
`16：9`映像を`4:3`へクロップできます。

## 使い方
~~~
    main.wsf arg1 [arg2 arg3 ...] [/Test] [/Height:value] [/Gop:value] [/Crf:value] [/Tune:string] [/Preset:string] [/A:value] [/B:value] [/Ext:string] [/Fps:string] [/Crop:{43, 43+}]
~~~
スクリプトと同じフォルダに`ffmpeg`と`ffprobe`を置いてください。
`main.wsf`にファイルをD&Dします。
### options
| option | argument | description | default |
|:---:|:---|:---|:---|
|/Test: |`true` or `false` |ffmpegのコマンドラインを表示します。エンコードは実行しません。 |false |
|/Heigh: |数値 |出力の縦解像度 |入力と同じ |
|/Gop: |数値 |gop長 |指定なし |
|/Crf: |数値 |crf値 |出力解像度より決定 |
|/Tune: |文字列 |tuneパラメータ |`animation` |
|/Preset: |文字列 |presetパラメータ |`slow` |
|/A: |数値 |a値 |`12.85097209` |
|/B: |数値 |b値 |`-55.17605647` |
|/Ext: |文字列 |出力ファイルの拡張子　コンテナを決める |`mkv` |
|/Fps: |文字列 or 数値 例:`24`,`24000/1001`|fps値 `24`,`24000/1001` |入力と同じ |
|/Crop: |`43` or `43+` |4:3へクロップ `43+`はやや幅広  |クロップしない |
`main.wsf`のショートカットを作成し、リンク先を`cscript.exe main.wsf /Height:720`等としておくと便利です。
