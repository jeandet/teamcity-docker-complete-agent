FROM jeandet/teamcity-docker-minimal-agent
LABEL maintainer "Alexis Jeandet <alexis.jeandet@member.fsf.org>"

RUN dnf update -y

RUN dnf install -y cppcheck luabind-devel tcl-devel tk-devel lua-devel python2-devel clang-devel ncurses-devel llvm-static clang-analyzer lcov openmpi-devel 
RUN dnf install -y git ninja-build ncurses-devel cups-devel zlib-static zlib-devel itstool libpcap-devel SDL2-devel wget redhat-rpm-config  gettext unzip doxygen
RUN dnf install -y gcc-objc++ flex flex-devel bison-devel bison gcc-objc libasan valgrind
RUN dnf install -y vala hg
RUN dnf install -y libwmf-devel qt5*-devel qt*-devel 
RUN dnf install -y llvm llvm-devel llvm3.9-devel llvm-static
RUN dnf install -y boost-*
RUN dnf install -y wxGTK-devel wxGTK3-devel
RUN dnf install -y glib2-devel gtest gobject-introspection-devel python-gobject-base python3-gobject-base gmock-devel gmock gtest-devel gtk3-devel
RUN dnf install -y openmpi mpich-devel environment-modules openmpi-devel
RUN dnf install -y mesa-vulkan-devel vulkan-devel 
RUN dnf install -y gnustep-base-devel gnustep-make
RUN dnf install -y graphviz texlive-* 

RUN git clone https://github.com/jeandet/vera.git /root/vera
RUN cd /root/vera && mkdir build && cd build && cmake ../ && make -j 4 && make install
	
	
RUN git clone https://github.com/KDE/clazy.git /root/clazy
RUN cd /root/clazy && mkdir build && cd build && cmake ../ && make -j 4 && make install

RUN echo "system.has_qt5=true" >> /opt/buildagent/conf/buildAgent.dist.properties && \
    echo "system.has_gcov=true" >> /opt/buildagent/conf/buildAgent.dist.properties && \
    echo "system.has_clang=true" >> /opt/buildagent/conf/buildAgent.dist.properties && \
    echo "system.has_clazy=true" >> /opt/buildagent/conf/buildAgent.dist.properties && \
    echo "system.has_cppcheck=true" >> /opt/buildagent/conf/buildAgent.dist.properties && \
    echo "system.has_clang_analyzer=true" >> /opt/buildagent/conf/buildAgent.dist.properties && \
    echo "system.has_lcov=true" >> /opt/buildagent/conf/buildAgent.dist.properties && \
    echo "system.has_openmpi=true" >> /opt/buildagent/conf/buildAgent.dist.properties


CMD ["/run-services.sh"]
