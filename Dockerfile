FROM jeandet/teamcity-docker-minimal-agent
LABEL maintainer "Alexis Jeandet <alexis.jeandet@member.fsf.org>"

RUN dnf install -y qt5-*devel git cppcheck luabind-devel tcl-devel tk-devel lua-devel python2-devel llvm-devel clang-devel ncurses-devel llvm-static clang-analyzer lcov openmpi-devel 

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
