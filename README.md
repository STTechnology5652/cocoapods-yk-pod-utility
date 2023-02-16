# cocoapods-ykutility

A description of cocoapods-ykutility.

## Installation

    gem install cocoapods-ykutility

## Usage

### 使用

- 快速创建pod

  ```shell
  pod ykutility create POD_NAME
  ```
  
  - 组件默认语言是 swift
  - 组件默认Prefix 是 YK
  - 组件默认 author email 会使用git的全局配置
  - 组件默认附带demo,用以调试组件

- 附带参数创建Pod
  
  帮助指令：

  ```shell
  pod ykutility create --help
  ```
  
  说明：

  - 通过帮助指令，可以查看参数列表
  - 带 '=' 号的参数是 options 类型参数，需要附带数值， 且 '='之间不要有空格， 例： --language=ojbc  --prefix=ST --pod-path="/Users/imac24inch/Desktop"
  - --no-demo 是flag类型参数， 不需要附带数值

### 帮助

不需要专门记忆插件名称，可通过cocoapods的帮助指令查看插件使用方法。

- 查看插件

  ```shell
  pod
  ```
  
  效果：
  ![img](./ReadMeResource/01.png)
  
- 查看插件指令集

  ```shell
  pod ykutility
  ```

  效果：
  ![img](./ReadMeResource/02.png)

- 查看组件指令使用说明

  ```shell
  pod ykutility create
  ```

  效果：
  ![img](./ReadMeResource/03.png)
