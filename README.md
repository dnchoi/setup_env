# Server Setting Env

## terminal & ssh & git  setting 
```bash
mv zshrc .zshrc
mv p10k.zsh .p10k.zsh
mv zsh-syntax-highlighting .zsh-syntax-highlighting
mv gitconfig .gitconfig
mv ssh .ssh
```

## Install SDK

### set running mode
```bash
sudo chmod 777 -R *
```

### install cuda
```bash
./cuda_installer.sh 11.1 8.0.5
```

### install cmake higher version
```bash
sudo cmake_install.sh
```

### install opencv
* enable CUDA
```bash
./opencv_installer.sh CUDA
```
* disable CUDA
```bash
./opencv_installer.sh
```

### install miniconda
```bash
./miniconda_installer.sh /home/$USER/miniconda3

# or

./miniconda_installer.sh $HOME/miniconda3
```

### install docker
```bash
./get-docker.sh
```
