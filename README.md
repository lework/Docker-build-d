## 版本信息

base image: `debian:stretch`

dmd version: `2.085.0`


## 编译

```
docker run --rm -v /root/app:/src -v /tmp/.dub:/root/.dub lework/build_d dub build
```
> /src              d语言源代码目录
>
> /root/.dub  dub依赖包目录

