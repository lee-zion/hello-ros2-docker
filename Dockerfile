FROM osrf/ros:humble-desktop-full-jammy

RUN apt-get update && apt-get install -y zsh curl git python3-pip vim
RUN gem update cgi

ARG UID GID
RUN groupadd -g $GID humble
RUN useradd -m -u $UID -g $GID -s $(which zsh) humble
USER humble

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

RUN echo "source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
RUN sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' ~/.zshrc
RUN echo 'source /opt/ros/humble/setup.zsh' >> ~/.zshrc
RUN echo 'alias cw="cd ~/ws"' >> ~/.zshrc
RUN echo 'alias cb="colcon build --symlink-install"' >> ~/.zshrc
RUN echo 'alias sc="source install/setup.zsh"' >> ~/.zshrc
RUN echo 'alias cc="rm -rf build install log"' >> ~/.zshrc
RUN echo 'alias cbsc="cw && cb && sc"' >> ~/.zshrc

# argcomplete for ros2 & colcon
RUN eval "$(register-python-argcomplete3 ros2)"
RUN eval "$(register-python-argcomplete3 colcon)"

CMD ["zsh"]