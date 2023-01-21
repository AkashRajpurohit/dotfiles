# Dotfiles

## Installing

You will need `git` and GNU `stow`

Clone into your `$HOME` directory or `~`

```bash
git clone https://github.com/AkashRajpurohit/dotfiles.git ~
```

Run `stow` to symlink everything or just select what you want

```bash
stow */ # Everything (the '/' ignores the README)
```

### Zsh
Install [zap](https://github.com/zap-zsh/zap) for managing plugins for zsh

```bash
stow zsh # Just my zsh config
```

