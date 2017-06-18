FROM jeandet/teamcity-docker-minimal-agent
LABEL maintainer "Alexis Jeandet <alexis.jeandet@member.fsf.org>"

RUN dnf install -y qt5-*devel git cppcheck luabind-devel tcl-devel tk-devel lua-devel python2-devel llvm-devel clang-devel ncurses-devel llvm-static clang-analyzer lcov openmpi-devel 

RUN git clone https://github.com/jeandet/vera.git /root/vera
RUN cd /root/vera && mkdir build && cd build && cmake ../ && make -j 4 && make install
	
	
RUN git clone https://github.com/KDE/clazy.git /root/clazy
RUN cd /root/clazy && mkdir build && cd build && cmake ../ && make -j 4 && make install

CMD ["/run-services.sh"]
