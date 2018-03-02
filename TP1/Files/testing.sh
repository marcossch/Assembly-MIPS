#/bin/bash

#solo se compila si no existia el archivo
if [ ! -f tp1 ]; then
  printf "Compiling..."
  bash compile.sh
  printf "Done.\n"
fi

# Empty file test
printf "\n"
printf "  Empty file tests:\n"
#new file
touch TestFiles/empty_output.txt
#variable [o|i]buf_sizes
# test 1-1
printf "    ibuf_size = 1    :: obuf_size = 1   ..."
./tp1 -i TestFiles/empty_input.txt -o TestFiles/empty_output.txt -I 1 -O 1
diff TestFiles/empty_input.txt TestFiles/empty_output.txt
printf "OK.\n"
# test 10-1
printf "    ibuf_size = 10   :: obuf_size = 1   ..."
./tp1 -i TestFiles/empty_input.txt -o TestFiles/empty_output.txt -I 10 -O 1
diff TestFiles/empty_input.txt TestFiles/empty_output.txt
printf "OK.\n"
# test 1-10
printf "    ibuf_size = 1    :: obuf_size = 10  ..."
./tp1 -i TestFiles/empty_input.txt -o TestFiles/empty_output.txt -I 1 -O 10
diff TestFiles/empty_input.txt TestFiles/empty_output.txt
printf "OK.\n"
# test 100-100
printf "    ibuf_size = 100  :: obuf_size = 100 ..."
./tp1 -i TestFiles/empty_input.txt -o TestFiles/empty_output.txt -I 100 -O 100
diff TestFiles/empty_input.txt TestFiles/empty_output.txt
printf "OK.\n"
# test 1000-100
printf "    ibuf_size = 1000 :: obuf_size = 100 ..."
./tp1 -i TestFiles/empty_input.txt -o TestFiles/empty_output.txt -I 1000 -O 100
diff TestFiles/empty_input.txt TestFiles/empty_output.txt
printf "OK.\n"
# test 100-1000
printf "    ibuf_size = 100  :: obuf_size = 1000..."
./tp1 -i TestFiles/empty_input.txt -o TestFiles/empty_output.txt -I 100 -O 1000
diff TestFiles/empty_input.txt TestFiles/empty_output.txt
printf "OK.\n"
# test 1-1000
printf "    ibuf_size = 1    :: obuf_size = 1000..."
./tp1 -i TestFiles/empty_input.txt -o TestFiles/empty_output.txt -I 1 -O 1000
diff TestFiles/empty_input.txt TestFiles/empty_output.txt
printf "OK.\n"
# test 1000-1
printf "    ibuf_size = 1000 :: obuf_size = 1   ..."
./tp1 -i TestFiles/empty_input.txt -o TestFiles/empty_output.txt -I 1000 -O 1
diff TestFiles/empty_input.txt TestFiles/empty_output.txt
printf "OK.\n"
#cleaning files
rm TestFiles/empty_output.txt

#Output File
printf "\n"
printf "  File Output testing:\n"
#archivo de entrada
printf "    In file: 'TestFiles/multiple_testing.txt'.\n"
#variable [o|i]buf_sizes
# test 1-1
printf "      ibuf_size = 1    :: obuf_size = 1   ..."
./tp1 -i TestFiles/multiple_testing.txt -o TestFiles/multiple_testing_out.txt -I 1 -O 1
diff TestFiles/multiple_testing_out.txt TestFiles/multiple_testing_res.txt
printf "OK.\n"
# test 10-1
printf "      ibuf_size = 10   :: obuf_size = 1   ..."
./tp1 -i TestFiles/multiple_testing.txt -o TestFiles/multiple_testing_out.txt -I 10 -O 1
diff TestFiles/multiple_testing_out.txt TestFiles/multiple_testing_res.txt
printf "OK.\n"
# test 1-10
printf "      ibuf_size = 1    :: obuf_size = 10  ..."
./tp1 -i TestFiles/multiple_testing.txt -o TestFiles/multiple_testing_out.txt -I 1 -O 10
diff TestFiles/multiple_testing_out.txt TestFiles/multiple_testing_res.txt
printf "OK.\n"
# test 100-100
printf "      ibuf_size = 100  :: obuf_size = 100 ..."
./tp1 -i TestFiles/multiple_testing.txt -o TestFiles/multiple_testing_out.txt -I 100 -O 100
diff TestFiles/multiple_testing_out.txt TestFiles/multiple_testing_res.txt
printf "OK.\n"
# test 1000-100
printf "      ibuf_size = 1000 :: obuf_size = 100 ..."
./tp1 -i TestFiles/multiple_testing.txt -o TestFiles/multiple_testing_out.txt -I 1000 -O 100
diff TestFiles/multiple_testing_out.txt TestFiles/multiple_testing_res.txt
printf "OK.\n"
# test 100-1000
printf "      ibuf_size = 100  :: obuf_size = 1000..."
./tp1 -i TestFiles/multiple_testing.txt -o TestFiles/multiple_testing_out.txt -I 100 -O 1000
diff TestFiles/multiple_testing_out.txt TestFiles/multiple_testing_res.txt
printf "OK.\n"
# test 1-1000
printf "      ibuf_size = 1    :: obuf_size = 1000..."
./tp1 -i TestFiles/multiple_testing.txt -o TestFiles/multiple_testing_out.txt -I 1 -O 1000
diff TestFiles/multiple_testing_out.txt TestFiles/multiple_testing_res.txt
printf "OK.\n"
# test 1000-1
printf "      ibuf_size = 1000 :: obuf_size = 1   ..."
./tp1 -i TestFiles/multiple_testing.txt -o TestFiles/multiple_testing_out.txt -I 1000 -O 1
diff TestFiles/multiple_testing_out.txt TestFiles/multiple_testing_res.txt
printf "OK.\n"
#file cleaning
rm TestFiles/multiple_testing_out.txt
#stdin
printf "    In file: stdin.\n"
#archivo de verificacion
touch TestFiles/test_res.txt
#test 1
printf "      One word palindrome:                ..."
echo palindromeemordnilap > TestFiles/test_res.txt
echo palindromeemordnilap | ./tp1 -o TestFiles/test_output.txt
diff TestFiles/test_res.txt TestFiles/test_output.txt
printf "OK.\n"
#test 2
printf "      One word non palindrome:            ..."
echo dada | ./tp1 -o TestFiles/test_output.txt
diff TestFiles/empty_input.txt TestFiles/test_output.txt
printf "OK.\n"
#test 3
printf "      Spaces only (no palindromes):       ..."
echo "!)$)=)?!=/=%)!?#)[{{{{}}]]]**¡¡!!}}*" | ./tp1 -o TestFiles/test_output.txt
diff TestFiles/empty_input.txt TestFiles/test_output.txt
printf "OK.\n"
#test 4
printf "      One char (MAYUS):                   ..."
echo R > TestFiles/test_res.txt
echo R | ./tp1 -o TestFiles/test_output.txt
diff TestFiles/test_res.txt TestFiles/test_output.txt
printf "OK.\n"
#test 5
printf "      One char (minus):                   ..."
echo r > TestFiles/test_res.txt
echo r | ./tp1 -o TestFiles/test_output.txt
diff TestFiles/test_res.txt TestFiles/test_output.txt
printf "OK.\n"
#test 6
printf "      One char (number):                  ..."
echo 8 > TestFiles/test_res.txt
echo 8 | ./tp1 -o TestFiles/test_output.txt
diff TestFiles/test_res.txt TestFiles/test_output.txt
printf "OK.\n"
#test 7
printf "      One char (-):                       ..."
echo - > TestFiles/test_res.txt
echo - | ./tp1 -o TestFiles/test_output.txt
diff TestFiles/test_res.txt TestFiles/test_output.txt
printf "OK.\n"
#test 8
printf "      One char (_):                       ..."
echo _ > TestFiles/test_res.txt
echo _ | ./tp1 -o TestFiles/test_output.txt
diff TestFiles/test_res.txt TestFiles/test_output.txt
printf "OK.\n"
#test 9
printf "      Multiple chars palindrome:          ..."
echo Ae4-_-4Ea > TestFiles/test_res.txt
echo Ae4-_-4Ea | ./tp1 -o TestFiles/test_output.txt
diff TestFiles/test_res.txt TestFiles/test_output.txt
printf "OK.\n"
#test 10
printf "      Multiple chars non palindrome:      ..."
echo 42J-kL_-Edkl1241 | ./tp1 -o TestFiles/test_output.txt
diff TestFiles/empty_input.txt TestFiles/test_output.txt
printf "OK.\n"
#test 11
printf "      Word division with char(space char):..."
cat > TestFiles/test_res.txt <<EOF
123_-_321
neUqUEn
EOF
echo "123_-_321&NONPALINDROME/(neUqUEn" | ./tp1 -o TestFiles/test_output.txt
diff TestFiles/test_res.txt TestFiles/test_output.txt
printf "OK.\n"
#file cleaning
rm TestFiles/test_output.txt
rm TestFiles/test_res.txt


#STDOUT
printf "\n"
printf "  Standard Output testing:\n"
#archivo de entrada
printf "    In file: 'TestFiles/multiple_testing.txt'.\n"
#variable [o|i]buf_sizes
# test 1-1
printf "      ibuf_size = 1    :: obuf_size = 1   ..."
./tp1 -i TestFiles/multiple_testing.txt -I 1 -O 1 > TestFiles/multiple_testing_out.txt
diff TestFiles/multiple_testing_out.txt TestFiles/multiple_testing_res.txt
printf "OK.\n"
# test 10-1
printf "      ibuf_size = 10   :: obuf_size = 1   ..."
./tp1 -i TestFiles/multiple_testing.txt -I 10 -O 1 > TestFiles/multiple_testing_out.txt
diff TestFiles/multiple_testing_out.txt TestFiles/multiple_testing_res.txt
printf "OK.\n"
# test 1-10
printf "      ibuf_size = 1    :: obuf_size = 10  ..."
./tp1 -i TestFiles/multiple_testing.txt -I 1 -O 10 > TestFiles/multiple_testing_out.txt
diff TestFiles/multiple_testing_out.txt TestFiles/multiple_testing_res.txt
printf "OK.\n"
# test 100-100
printf "      ibuf_size = 100  :: obuf_size = 100 ..."
./tp1 -i TestFiles/multiple_testing.txt -I 100 -O 100 > TestFiles/multiple_testing_out.txt
diff TestFiles/multiple_testing_out.txt TestFiles/multiple_testing_res.txt
printf "OK.\n"
# test 1000-100
printf "      ibuf_size = 1000 :: obuf_size = 100 ..."
./tp1 -i TestFiles/multiple_testing.txt -I 1000 -O 100 > TestFiles/multiple_testing_out.txt
diff TestFiles/multiple_testing_out.txt TestFiles/multiple_testing_res.txt
printf "OK.\n"
# test 100-1000
printf "      ibuf_size = 100  :: obuf_size = 1000..."
./tp1 -i TestFiles/multiple_testing.txt -o TestFiles/multiple_testing_out.txt -I 100 -O 1000
diff TestFiles/multiple_testing_out.txt TestFiles/multiple_testing_res.txt
printf "OK.\n"
# test 1-1000
printf "      ibuf_size = 1    :: obuf_size = 1000..."
./tp1 -i TestFiles/multiple_testing.txt -I 1 -O 1000 > TestFiles/multiple_testing_out.txt
diff TestFiles/multiple_testing_out.txt TestFiles/multiple_testing_res.txt
printf "OK.\n"
# test 1000-1
printf "      ibuf_size = 1000 :: obuf_size = 1   ..."
./tp1 -i TestFiles/multiple_testing.txt -I 1000 -O 1 > TestFiles/multiple_testing_out.txt
diff TestFiles/multiple_testing_out.txt TestFiles/multiple_testing_res.txt
printf "OK.\n"
#file cleaning
rm TestFiles/multiple_testing_out.txt
#stdin
printf "    In file: stdin.\n"
#archivo de verificacion
touch TestFiles/test_res.txt
#test 1
printf "      One word palindrome:                ..."
echo palindromeemordnilap > TestFiles/test_res.txt
echo palindromeemordnilap | ./tp1 -I 4 -O 2 > TestFiles/test_output.txt
diff TestFiles/test_res.txt TestFiles/test_output.txt
printf "OK.\n"
#test 2
printf "      One word non palindrome:            ..."
echo dada | ./tp1 -I 2 -O 4 > TestFiles/test_output.txt
diff TestFiles/empty_input.txt TestFiles/test_output.txt
printf "OK.\n"
#test 3
printf "      Spaces only (no palindromes):       ..."
echo "!)$)=)?!=/=%)!?#)[{{{{}}]]]**¡¡!!}}*" | ./tp1 > TestFiles/test_output.txt
diff TestFiles/empty_input.txt TestFiles/test_output.txt
printf "OK.\n"
#test 4
printf "      One char (MAYUS):                   ..."
echo R > TestFiles/test_res.txt
echo R | ./tp1 -I 10 -O 10 > TestFiles/test_output.txt
diff TestFiles/test_res.txt TestFiles/test_output.txt
printf "OK.\n"
#test 5
printf "      One char (minus):                   ..."
echo r > TestFiles/test_res.txt
echo r | ./tp1 -I 5 -O 3 > TestFiles/test_output.txt
diff TestFiles/test_res.txt TestFiles/test_output.txt
printf "OK.\n"
#test 6
printf "      One char (number):                  ..."
echo 8 > TestFiles/test_res.txt
echo 8 | ./tp1 > TestFiles/test_output.txt
diff TestFiles/test_res.txt TestFiles/test_output.txt
printf "OK.\n"
#test 7
printf "      One char (-):                       ..."
echo - > TestFiles/test_res.txt
echo - | ./tp1 > TestFiles/test_output.txt
diff TestFiles/test_res.txt TestFiles/test_output.txt
printf "OK.\n"
#test 8
printf "      One char (_):                       ..."
echo _ > TestFiles/test_res.txt
echo _ | ./tp1 > TestFiles/test_output.txt
diff TestFiles/test_res.txt TestFiles/test_output.txt
printf "OK.\n"
#test 9
printf "      Multiple chars palindrome:          ..."
echo Ae4-_-4Ea > TestFiles/test_res.txt
echo Ae4-_-4Ea | ./tp1 > TestFiles/test_output.txt
diff TestFiles/test_res.txt TestFiles/test_output.txt
printf "OK.\n"
#test 10
printf "      Multiple chars non palindrome:      ..."
echo 42J-kL_-Edkl1241 | ./tp1 -I 15 -O 20 > TestFiles/test_output.txt
diff TestFiles/empty_input.txt TestFiles/test_output.txt
printf "OK.\n"
#test 11
printf "      Word division with char(space char):..."
cat > TestFiles/test_res.txt <<EOF
123_-_321
neUqUEn
EOF
echo "123_-_321&NONPALINDROME/(neUqUEn" | ./tp1 > TestFiles/test_output.txt
diff TestFiles/test_res.txt TestFiles/test_output.txt
printf "OK.\n"
#file cleaning
rm TestFiles/test_output.txt
rm TestFiles/test_res.txt


#invalid buffer sizes testing
printf "\n"
printf "  Invalid buffer sizes test: [should set 1 by default]\n"
touch TestFiles/multiple_testing_out.txt
#test 1
printf "    ibuf_size = -1 :: obuf_size = 10      ..."
./tp1 -I "-1" -O 10 -i TestFiles/multiple_testing.txt -o TestFiles/multiple_testing_out.txt
diff TestFiles/multiple_testing_out.txt TestFiles/multiple_testing_res.txt
printf "OK.\n"
#test 2
printf "    ibuf_size = 10 :: obuf_size = -1      ..."
./tp1 -I 10 -O "-1" -i TestFiles/multiple_testing.txt -o TestFiles/multiple_testing_out.txt
diff TestFiles/multiple_testing_out.txt TestFiles/multiple_testing_res.txt
printf "OK.\n"
#test 3
printf "    ibuf_size = -1 :: obuf_size = -1      ..."
./tp1 -I "-1" -O "-1" -i TestFiles/multiple_testing.txt -o TestFiles/multiple_testing_out.txt
diff TestFiles/multiple_testing_out.txt TestFiles/multiple_testing_res.txt
printf "OK.\n"
#test 4
printf "    ibuf_size = 0  :: obuf_size = 0       ..."
./tp1 -I "-1" -O 0 -i TestFiles/multiple_testing.txt -o TestFiles/multiple_testing_out.txt
diff TestFiles/multiple_testing_out.txt TestFiles/multiple_testing_res.txt
printf "OK.\n"
#file cleaning
rm TestFiles/multiple_testing_out.txt
