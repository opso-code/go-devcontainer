# Development Container for Golang

## 说明

这是一个利用容器 *Docker* 技术快速搭建统一的Golang开发环境的项目，用于在编辑器中载入项目时，提供独立的一个容器作为开发环境，也可以进行一些初始化/编译打包等工作

## 环境

- Docker Desktop for Windows/macOS
- 支持`.devcontainer`的编辑器（`VS Code`或者`Goland 2023.2`等）

## 如何使用

首先将项目clone到自己golang项目的目录下，示例是在`workspace`

```bash
$ cd workspace
$ git clone https://github.com/opso-code/go-devcontainer.git
```

编辑配置文件 `.devcontainer/devcontainer.json`

```json
{
    "name": "Go",
    "build": {
        "dockerfile": "Dockerfile",
        "args": {
            "VARIANT": "1.18",
            "CHANGE_SOURCE": "false",
            "PROTOBUFF_VERSION": "3.17.3",
            "PROTO_GEN_GO_VERSION": "1.28.0",
            "PROTOC_GEN_GRPC_GATEWAY": "2.12.0"
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
                "zxh404.vscode-proto3"
            ]
        }
    }, 
    "mounts": [
      "source=${localEnv:HOME}/.zsh_history,target=/root/.zsh_history,type=bind"
    ],
    "workspaceMount": "source=${localWorkspaceFolder}/../,target=/workspace,type=bind,consistency=cached",
    "workspaceFolder": "/workspace",
    "hostRequirements": {
      "memory": "4gb"
    },
    "remoteEnv": {
      "PATH": "${containerEnv:PATH}:/usr/local/protoc/bin"
    }
}
```

Golang版本默认是镜像 `golang:1.18`，可以修改为自己需要的版本，除此之外安装了以下工具，版本可以自定义

- oh-my-zsh
- protoc v3.17.3
- protoc-gen-go v1.28.0
- protoc-gen-grpc-gateway v2.12.0

如果你的系统是在`macOS`或者`Linux`下，有安装`zsh`，则这里推荐打开以下配置，同步宿主机里的bash命令历史

```json
{
    "mounts": [
      "source=${localEnv:HOME}/.zsh_history,target=/root/.zsh_history,type=bind"
    ]
}
```

## 扩展安装

### GoLand

GoLand从 `2023.2` 开始支持了`devcontainer` 目前还没有看到扩展安装相关的支持，有兴趣可以按照官方实例研究下 https://www.jetbrains.com/help/go/connect-to-devcontainer.html

### VS Code

VS Code Container官方文档地址 https://code.visualstudio.com/docs/remote/containers

| 扩展         | 标识                      | 作用            | 推荐度 |
|------------|-------------------------|---------------|-----|
| Go         | golang.go               | Golang开发必须    | 必须  |
| GitHistory | donjayamanne.githistory | 可以在文件中查看git历史 | 建议  |
| GitLens    | eamodio.gitlens         | 便于查看git分支数据   | 建议  |
| proto3     | zxh404.vscode-proto3    | protobuf文件支持  | 非必须 |

## 如何启动

### Goland 

打开文件 `.devcontainer/devcontainer.json` 点击文件最左上角Docker🐳图标 

### VS Code

远程资源管理器 / 开发容器下拉菜单下 或者VS Code加载时候按照弹出提示操作。