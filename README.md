# VS Code devcontainer for Golang

## 说明

这是一个基于容器 *Container* (`docker`/`podman`)，依赖`VS Code devcontainer` 功能的开发环境搭建配置，能够快速部署`golang`开发环境，特别是在`macOS`或是`Windows`下开发，需要依赖`cgo`的情况下。

官方文档地址 https://code.visualstudio.com/docs/remote/containers

## 配置

```json
{
    "name": "Go",
    "build": {
        "dockerfile": "Dockerfile",
        "args": {
            "VARIANT": "1.18",               // 指定golang版本
            "CHANGE_SOURCE": "false",        // 是否使用apt国内源加速下载
            "PROTOBUFF_VERSION": "3.17.3",   // protobuff版本
            "PROTO_GEN_GO_VERSION": "1.28.0" // proto_gen_go扩展版本
        }
    },
    "customizations": {
        "vscode": {
            "settings": {},
            "extensions": [
                "golang.go",
                "bungcip.better-toml",
                "donjayamanne.githistory",
                "eamodio.gitlens",
                "zxh404.vscode-proto3",
                // ... 可以在这里加上自定义插件的ID
            ]
        }
    },
}
```

## 启动

可以从 `远程资源管理器 -> Containers-> Dev Containers` 中启动，或者`VSCode` 加载时候弹出提示。