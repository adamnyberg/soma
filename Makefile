QUICKRUN=-O3
MAKEFLAGS=-aL/home/TDDD11/lib/TJa/lib/Solaris -aI/home/TDDD11/lib/TJa/src/Solaris -aO/home/TDDD11/lib/TJa/lib/Solaris

lsoma:
	gnatmake $(QUICKRUN) $(MAKEFLAGS) src/soma.adb
	./soma; rm soma;

ltest:
	gnatmake $(MAKEFLAGS) -Isrc/\
		tests/test_parts.adb tests/test_misc.adb tests/test_figures.adb\
		tests/test_packets.adb tests/test_bits.adb;
	echo "\n"; ./test_parts; ./test_misc; ./test_figures; ./test_packets; rm test_*;
	echo "All tests succeeded!"

soma: sync
	ssh $(liu_id)@astmatix.ida.liu.se \
		"cd soma;bash -l -c 'export PATH=/bin:/sw/gcc-3.4.6/bin:/usr/ccs/bin;make lsoma'"

test: sync
	ssh $(liu_id)@astmatix.ida.liu.se \
		"cd soma;bash -l -c 'export PATH=/bin:/sw/gcc-3.4.6/bin:/usr/ccs/bin;make ltest'"

ptest:
	gnatmake -f -pg -Isrc/\
		tests/test_$(pack).adb;
	echo "\n"; ./test_$(pack);
	#rm test_*;
	echo "Test succeeded!";

iptest:
	gnatmake $(MAKEFLAGS) -Isrc/\
		tests/test_$(pack).adb;
	echo "\n"; ./test_$(pack); rm test_*;
	echo "Test succeeded!";

sptest: sync
	ssh $(liu_id)@astmatix.ida.liu.se \
		"cd soma;bash -l -c 'export PATH=/bin:/sw/gcc-3.4.6/bin:/usr/ccs/bin;make iptest pack=$(pack)'"

prof:
	make ptest pack=solver;
	gprof ./test_solver;
	gprof test_solver gmon.out > prf;
	head -n30 prf;
	#rm gmon.out test_*;

vinit:
	ssh -X $(liu_id)@astmatix.ida.liu.se 'mkdir -p soma; cd soma; /sw/gnu/bin/wget --no-clobber\
		http://www.ida.liu.se/~TDDC68/2013/Matr/SN/Info_Ada/proj/files/soma-visual.jar;\
		/usr/jdk/instances/jdk1.7.0/bin/java -jar soma-visual.jar'

tinit:
	ssh -X $(liu_id)@astmatix.ida.liu.se 'mkdir -p soma/puzzles; cd soma/puzzles; /sw/gnu/bin/wget --no-clobber\
		http://www.ida.liu.se/~TDDC68/2013/Matr/SN/Info_Ada/proj/files/Server/server;\
		/usr/bin/chmod 777 server; /usr/local/bin/expect server_conf.sh'

ftinit:
	ssh -X $(liu_id)@astmatix.ida.liu.se 'mkdir -p soma/puzzles; cd soma/puzzles; /sw/gnu/bin/wget\
		http://www.ida.liu.se/~TDDC68/2013/Matr/SN/Info_Ada/proj/files/Server/server;\
		/usr/bin/chmod 777 server; /usr/local/bin/expect server_conf.sh'

sync:
	rsync -rlp --exclude '.git' . $(liu_id)@astmatix.ida.liu.se:soma

clean: sclean; lclean

sclean:
	ssh $(liu_id)@astmatix.ida.liu.se "rm soma/soma"

lclean:
	rm -R *.o *.ali

solver: soma
