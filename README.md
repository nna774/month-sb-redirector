# month-sb-redirector

<https://scrapbox.io/rebuild-kitashirakawa/2022%2F05> のようなカレンダーページを作るくん

## つかいかた

基本的にはデプロイされているlambaから実行するとよい。

もし過去に遡って実行したくなった場合は、

```sh
bundle exec ruby main.rb 2022/05/01
```

のように実行するとその月のリンクが生成されるようにしておいた。
