# Lux DNS 

LXC: Debain 11

```sh
cp /etc/apt/sources.list /etc/apt/sources.list.bak
# Debain
echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware" >> /etc/apt/sources.list
echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware" >> /etc/apt/sources.list
echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware" >> /etc/apt/sources.list
echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware" >> /etc/apt/sources.list
apt update
```

### 配置时区

```sh
timedatectl set-timezone Asia/Shanghai
```

### 安装基础软件

> 除除了 git, curl, unzip 其他看心情

```sh

# 基础软件
apt install git curl unzip zsh build-essential

# 切换zsh
chsh -s $(which zsh)
# 安装 starship
curl -sS https://starship.rs/install.sh | sh
# eval "$(starship init zsh)"
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
echo 'source ~/.bashrc' >> ~/.zshrc
# 安装 nvim
rm -rf /usr/local/nvim
rm -rf /usr/share/nvim
rm -rf ~/.config/nvim
rm -rf /usr/local/nvim
rm -rf /usr/local/vi
rm -rf /usr/local/vim
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar -xvzf nvim-linux64.tar.gz &&  mv nvim-linux64 nvim && mv nvim /usr/local/
ln -s /usr/local/nvim/bin/nvim /usr/local/bin/nvim
ln -s /usr/local/nvim/bin/nvim /usr/local/bin/vim
ln -s /usr/local/nvim/bin/nvim /usr/local/bin/vi
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim

```

