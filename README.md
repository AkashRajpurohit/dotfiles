<h1 align="center">
  <img src="./terminal.jpeg" alt="terminal screenshot" />
  <br />
  Dotfiles
  <br />
  <p align="center">
  <a href="https://github.com/AkashRajpurohit/dotfiles"><img src="https://visitor-badge.laobi.icu/badge?page_id=akashrajpurohit-dotfiles.visitor-badge" height="20"></a>
  <a href="https://github.com/AkashRajpurohit/dotfiles/stargazers"><img src="https://img.shields.io/github/stars/AkashRajpurohit/dotfiles" height="20"></a>
  <a href="https://github.com/AkashRajpurohit/dotfiles/network/members"><img src="https://img.shields.io/github/forks/AkashRajpurohit/dotfiles" height="20"></a>
  <a href="https://github.com/AkashRajpurohit/dotfiles/issues?q=is%3Aopen+is%3Aissue"><img src="https://img.shields.io/github/issues/AkashRajpurohit/dotfiles" height="20"></a>
  <a href="https://github.com/AkashRajpurohit/dotfiles/blob/main/LICENSE"><img src="https://img.shields.io/github/license/AkashRajpurohit/dotfiles" height="20"></a>
  <a href="https://twitter.com/intent/tweet?url=https%3A%2F%2Fgithub.com%2FAkashRajpurohit%2Fdotfiles"><img src="https://img.shields.io/twitter/url?url=https%3A%2F%2Fgithub.com%2FAkashRajpurohit%2Fdotfiles" height="20"></a>
  </p>
</h1>

## Installing

You will need `git` and GNU [`stow`](https://github.com/aspiers/stow)

Clone into your `$HOME/dotfiles` directory or `~/dotfiles`

```bash
git clone https://github.com/AkashRajpurohit/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### Zsh

Install [zap](https://github.com/zap-zsh/zap) for managing plugins for zsh

```bash
stow zsh
```

### Neovim

Install [neovim](https://github.com/neovim/neovim) >= 0.8

```bash
stow nvim
```

## Credits

- Managing dotfiles with Stow by chris@machine -> [Video](https://www.youtube.com/watch?v=90xMTKml9O0)
- Effective Neovim by TJ DeVries -> [Video](https://www.youtube.com/watch?v=stqUbv-5u2s), [Github](https://github.com/nvim-lua/kickstart.nvim)

