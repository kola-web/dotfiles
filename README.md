## 安装

### 必需品

    . git
    . stow

克隆到你的 `$HOME` 目录或 `~`

```bash
git clone --recurse-submodules https://github.com/kola-web/dotfiles.git ~/dotfiles
```

运行`stow`对所有内容进行符号链接或仅选择您想要的内容

```bash
stow */ 映射所有目录
```

```bash
stow zsh # 仅使用zsh
```

## 手动初始化和更新子模块

如果你已经克隆了主仓库，并且想在之后克隆所有子模块，可以使用以下命令：

```bash
git submodule update --init --recursive
```
