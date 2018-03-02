#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <stdbool.h>
#include <ctype.h>
#include <unistd.h>
#include <errno.h>
#include <getopt.h>

#define DEFAULT_INPUT stdin
#define DEFAULT_OUTPUT stdout

#define SIZE_INC 64
#define INIT_SIZE 256

#define OBYTES 4
#define IBYTES 4

#define ALLOC_ERROR "An error ocurred while allocating memory! Error: "
#define REALLOC_ERROR "An error ocurred while reallocating memory! Error: "
#define INPUT_OPEN_ERROR "An error ocurred while opening input file! Error: "
#define OUTPUT_OPEN_ERROR "An error ocurred while opening output file! Error: "
#define RESULT_WRITING_ERROR "An error ocurred while writing the result! Error: "
#define PALINDROME_ERROR_MESSAGE "An error ocurred while checking for palindromes!"

#define END_PROGRAM 8 //Parametros de entrada

#define WRITING_ERROR 2
#define PALINDROME_ERROR 3
#define BAD_ARGUMENTS 4
#define BAD_INPUT_PATH 5
#define BAD_OUTPUT_PATH 6
#define READING_ERROR 7

#define FAIL 1
#define SUCCESS 0

bool is_space(char c){
  /*Todos los casos en los que NO es espacio*/
  if ((c>47 && c<58)||(c>64 && c<91)||(c>96 && c<123)||(c==95)||(c==45))
    return false;
  /*Sino, es espacio.*/
  return true;
}

char* strrev(char *str){
  char *p1, *p2;
  if (! str || ! *str) return str;
    for (p1 = str, p2 = str + strlen(str) - 1; p2 > p1; ++p1, --p2){
      *p1 ^= *p2;
      *p2 ^= *p1;
      *p1 ^= *p2;
    }
  return str;
}

bool is_palindrome(char* string){
  /* Si tiene un solo caracter entonces es palindromo */
  int len = strlen(string) + 1;
  if (len < 1|| !strcmp(string,"")) return false;
  else if (len == 1) return true;
  /*Analizamos la palabra*/
  bool result = false;
  /*Pasamos a minuscula los caracteres*/
  int size = INIT_SIZE;
  char* lower = malloc(sizeof(char)*size);
  memset(lower, 0, sizeof(char)*size);
  //Pasamos a minuscula
  int i;
  for(i = 0; i < len; i++){
    if (i == size) lower = realloc(lower, sizeof(char)*(size += SIZE_INC) );
    lower[i] = tolower((unsigned char)string[i]);
  }
  lower[i] = '\0'; //Fin de cadena
  /*Verificamos si es capicua*/
  char* copy = malloc(sizeof(char)*size);
  /*Se copia y se invierte*/
  strcpy(copy, lower);
  strrev(copy);
  if(!strcmp(lower, copy)) result = true;
  //Se liberan los strings usados
  free(lower);
  free(copy);

  return result;
}

void write_word(char* string, char* obuffer, int obytes, FILE* fp){
  size_t len = strlen(string);
  size_t out = strlen(obuffer);

  for (int i = 0; i < len; i++){
    obuffer[out++] = string[i];
    if (out == obytes){
      fprintf(fp, "%s", obuffer);
      memset(obuffer, 0, sizeof(char)*obytes);
      out = 0;
    }
  }
}

int fill_buffer(FILE* fp, char* buffer, int ibytes){
  char c;
  int i = 0;
  while ( EOF != (c = fgetc(fp)) ){
    buffer[i++] = c;
    if (i == ibytes) break;
  }
  return i;
}

int process_input(FILE* ifp, FILE* ofp, int ibytes, int obytes){
  char* string; //Lugar donde se guardan las palabras que se van leyendo
  char ibuffer[ibytes];
  memset(ibuffer, 0, ibytes);
  char obuffer[obytes];
  char c; //Caracter leido
  int read;
  size_t len = 0; //Tamaño actual del string
  size_t size = INIT_SIZE;

  /*Se pide memoria para el string*/
  string = malloc( sizeof(char)*size );
  memset(string, 0, size);

  bool running = true;

  /*Procesamiento del archivo*/
  while(running){
      read = fill_buffer(ifp, ibuffer, ibytes);
      if (!read) running = false;
      for (int j = 0; j < read; j++){
        c = ibuffer[j];
        /*En cada caracter hay que ver si es espacio*/
        if (is_space(c)){
          /*En caso de serlo, vemos si la palabra hasta el momento era capicua*/
          if (is_palindrome(string)){
            string[len] = '\n';
            write_word(string, obuffer, obytes, ofp);
          }
          /*Borramos la palabra previa*/
          memset(string, 0, len);
          len = 0;
          /*Volvemos a empezar*/
          continue;
        }
      /*Se agrega el caracter al arreglo*/
      string[len++] = c;
      /*Si el string alcanza el largo máximo, hay que redimensionar el arreglo*/
      if (len == size) string = realloc(string, sizeof(char)*(size += SIZE_INC));
    }
  }
  /*Se escribe lo que quedo del buffer*/
  fprintf(ofp, "%s", obuffer);
  /*libera el string*/
  free(string);

  return SUCCESS;
}

FILE* open_input(char* path){
  //Se intenta abrir el archivo
  FILE* input_fp;
  //path == NUll significa stdin
  if (!path) input_fp = DEFAULT_INPUT;
  else {
    input_fp = fopen(path, "r");
    //Notificacion de error
    if (!input_fp) printf("%s%s\n", INPUT_OPEN_ERROR, strerror(errno));
  }
  return input_fp;
}

FILE* open_output(char* path){
  //Se intenta abrir el archivo
  FILE* output_fp;
  //path == NULL signifca stdout
  if (!path) output_fp = DEFAULT_OUTPUT;
  else{
    output_fp = fopen(path, "w");
    //Notificacion de error
    if (!output_fp) printf("%s%s\n", OUTPUT_OPEN_ERROR, strerror(errno));
  }
  return output_fp;
}

void close_files(FILE* fp1, FILE* fp2){
  fclose(fp1);
  fclose(fp2);
}

void print_help(){
  printf("Usage:\n \
  \ttp0 -h\n \
  \ttp0 -v\n \
  \ttp0 [options]\nOptions:\n \
  \t-v, --version    \tPrint version and quit.\n \
  \t-h, --help       \tPrint help and quit.\n \
  \t-i, --input      \tPath to input file.\n \
  \t-o, --output     \tPath to output file.\nExamples:\n \
  \ttp0 -i ~/input -o ~/output\n");
}

void print_version(){
  printf("tp0 [Guerrero - Schapira - De Rosa] v0.8\n");
}

int process_params(int argc, char** argv, char** input_file, char** output_file){
  int c;
  while (1){
    static struct option long_options[] =
      {
        /* These options don’t set a flag.
           We distinguish them by their indices. */
        {"help", no_argument, 0, 'h'},
        {"version", no_argument, 0, 'v'},
        {"input",  required_argument, 0, 'i'},
        {"output",    required_argument, 0, 'o'},
        {0, 0, 0, 0}
      };
      /* getopt_long stores the option index here. */
      int option_index = 0;

      c = getopt_long(argc, argv, "hvc:i:o:", long_options, &option_index);

      /* Detect the end of the options. */
      if (c == -1) break;

      switch (c){
        case 0:
          /* If this option set a flag, do nothing else now. */
          if (long_options[option_index].flag != 0) break;
          printf ("option %s", long_options[option_index].name);
          if (optarg) printf (" with arg %s", optarg);
          printf ("\n");
          break;
        case 'h':
          print_help();
          return END_PROGRAM;
          break;
        case 'v':
          print_version();
          return END_PROGRAM;
          break;
        case 'i':
          *input_file = optarg;
          break;
        case 'o':
          *output_file = optarg;
          break;
        case ':':
          return BAD_ARGUMENTS;
          break;
        case '?':
          return BAD_ARGUMENTS;
          break;
        default:
          return BAD_ARGUMENTS;
      }
  }
  /* Print any remaining command line arguments (not options). */
  if (optind < argc){
      printf ("non-option ARGV-elements: ");
      while(optind < argc) printf("%s ", argv[optind++]);
      putchar('\n');
  }
  return SUCCESS;
}

int main(int argc, char** argv){
  /* Archivos */
  char* output_file = NULL;
  char* input_file = NULL;
  /* Procesamiento de parametros de entrada*/
  int processing = process_params(argc, argv, &input_file, &output_file);
  if (processing != SUCCESS){
    if (processing == BAD_ARGUMENTS) return BAD_ARGUMENTS;
    else return SUCCESS;
  }
  //Apertura de archivos
  //Entrada
  FILE* input_fp = open_input(input_file);
  if (!input_fp) return BAD_INPUT_PATH;
  //Salida
  FILE* output_fp = open_output(output_file);
  if (!output_fp){
    fclose(input_fp);
    return BAD_OUTPUT_PATH;
  }
  //Lectura del archivo
  process_input(input_fp, output_fp, IBYTES, OBYTES);

  close_files(input_fp, output_fp);

  return 0;
}
