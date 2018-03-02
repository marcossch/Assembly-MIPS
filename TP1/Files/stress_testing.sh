#/bin/bash

#solo se compila si no existia el archivo
if [ ! -f tp1 ]; then
  printf "Compiling..."
  bash compile.sh
  printf "Done.\n"
fi

#stress tests
printf "\n"
printf "  Stress tests: [1Mb file]\n"
printf "\n    ibuf_size == obuf_size\n"
#test 1-1
printf "      ibuf_size = 1    :: obuf_size = 1   ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 1 -I 1
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 16-16
printf "      ibuf_size = 16   :: obuf_size = 16  ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 16 -I 16
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 32-32
printf "      ibuf_size = 32   :: obuf_size = 32  ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 32 -I 32
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 64-64
printf "      ibuf_size = 64   :: obuf_size = 64  ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 64 -I 64
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 128-128
printf "      ibuf_size = 128  :: obuf_size = 128 ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 128 -I 128
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 1024-1024
printf "      ibuf_size = 1024 :: obuf_size = 1024..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 1024 -I 1024
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 4096-4096
printf "      ibuf_size = 4096 :: obuf_size = 4096..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 4096 -I 4096
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."

####
printf "\n    ibuf_size != obuf_size\n"
#test 1-16
printf "      ibuf_size = 1    :: obuf_size = 16  ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 16 -I 1
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 1-32
printf "      ibuf_size = 1    :: obuf_size = 32  ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 32 -I 1
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 1-64
printf "      ibuf_size = 1    :: obuf_size = 64  ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 64 -I 1
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 1-128
printf "      ibuf_size = 1    :: obuf_size = 128 ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 128 -I 1
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 1-16
printf "      ibuf_size = 16   :: obuf_size = 1   ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 1 -I 16
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 1-32
printf "      ibuf_size = 16   :: obuf_size = 32  ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 32 -I 16
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 1-64
printf "      ibuf_size = 16   :: obuf_size = 64  ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 64 -I 16
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 1-128
printf "      ibuf_size = 16   :: obuf_size = 128 ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 128 -I 16
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 1-16
printf "      ibuf_size = 32   :: obuf_size = 16  ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 16 -I 32
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 1-32
printf "      ibuf_size = 32   :: obuf_size = 1   ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 1 -I 32
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 1-64
printf "      ibuf_size = 32   :: obuf_size = 64  ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 64 -I 32
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 1-128
printf "      ibuf_size = 32   :: obuf_size = 128 ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 128 -I 32
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 1-16
printf "      ibuf_size = 64   :: obuf_size = 16  ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 16 -I 64
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 1-32
printf "      ibuf_size = 64   :: obuf_size = 32  ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 32 -I 64
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 1-64
printf "      ibuf_size = 64   :: obuf_size = 1   ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 1 -I 64
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 1-128
printf "      ibuf_size = 64   :: obuf_size = 128 ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 128 -I 64
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 1-16
printf "      ibuf_size = 128  :: obuf_size = 16  ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 16 -I 128
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 1-32
printf "      ibuf_size = 128   :: obuf_size = 32  ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 32 -I 128
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 1-64
printf "      ibuf_size = 128   :: obuf_size = 64   ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 64 -I 128
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#test 128-1
printf "      ibuf_size = 128  :: obuf_size = 1   ..."
STARTTIME=$(date +%s)
./tp1 -i TestFiles/stress_test.txt -o TestFiles/stress_out.txt -O 1 -I 128
ENDTIME=$(date +%s)
diff TestFiles/stress_test_res.txt TestFiles/stress_out.txt
printf "OK.\n"
echo "        Time elapsed: $(($ENDTIME - $STARTTIME))s."
#file cleaning
rm TestFiles/stress_out.txt
