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
#define DEFAULT_OBYTES 1
#define DEFAULT_IBYTES 1
#define IBYTES 0
#define OBYTES 1

#define INPUT_OPEN_ERROR "An error ocurred while opening input file! Error: "
#define OUTPUT_OPEN_ERROR "An error ocurred while opening output file! Error: "
#define PALINDROME_ERROR "An error ocurred while checking for palindromes!"
#define INPUT_MALLOC_MESSAJE "An error ocurred in malloc while reading from input!"
#define OUTPUT_MALLOC_MESSAJE "An error ocurred in malloc while reading from output!"
#define WRITE_MESSAJE "An error ocurred while writing in palindrome function!"
#define READ_MESSAJE "An error ocurred while reading in palindrome function!"

#define END_PROGRAM 8 //Parametros de entrada

#define BAD_ARGUMENTS 4
#define BAD_INPUT_PATH 5
#define BAD_OUTPUT_PATH 6

#define INPUT_MALLOC_ERROR 1
#define OUTPUT_MALLOC_ERROR 2
#define WRITE_ERROR 3
#define READ_ERROR 4

#define FAIL 1
#define SUCCESS 0

/*Se abre el input_file y se devuelve su fp. En caso de error al abrir,
  se utiliza DEFAULT_INPUT.
 * @param path: Direccion del archivo a abrir.
 * @return: File Pointer de input [default: DEFAULT_INPUT].*/
FILE* open_input(char* path);
/*Se abre el output_file y se devuelve su fp. En caso de error al abrir,
  se utiliza DEFAULT_OUTPUT.
 * @param path: Direccion del archivo a abrir.
 * @return: File Pointer de output [default: DEFAULT_OUTPUT].*/
FILE* open_output(char* path);
/*Cierra los dos archivos recibidos.
 * @param fp1, fp2: File Pointer de archivo a cerrar.*/
void close_files(FILE* fp1, FILE* fp2);
/*Imprime por consola la informacion de los comandos por consola y el
uso del programa.*/
void print_help();
/*Imprime por consola la version del programa*/
void print_version();
/*Procesa los parametros de entrada del programa y almacena los paths
correspondientes en los parametros de la funcion.
 * @param argc: Cantidad de argumentos del programa.
 * @param argv: Vector de argumentos del programa.
 * @param input_file: Puntero al string donde se guarda el path de input.
 * @param output_file: Puntero al string donde se guarda el path de output.
 * @return: SUCCESS | BAD_ARGUMENTS.*/
int process_params(int argc, char** argv, char** input_file, char** output_file, char** ibytes, char** obytes);
//extern char* palindrome(int ifd, size_t ibytes, int ofd, size_t obytes);
extern int palindrome(int ifd, size_t ibytes, int ofd, size_t obytes);

int main(int argc, char** argv){
  char* output_file = NULL;
  char* input_file = NULL;
  char* ibytes = NULL;
  char* obytes = NULL;
  /* Procesamiento de parametros de entrada*/
  int processing = process_params(argc, argv, &input_file, &output_file, &ibytes, &obytes);
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
  //Definicion de bytes de los buffers
  int ib = 0;
  int ob = 0;
  if (ibytes) ib = atoi(ibytes);
  if (obytes) ob = atoi(obytes);
  if (ib < 1) ib = DEFAULT_IBYTES;
  if (ob < 1) ob = DEFAULT_OBYTES;
  //Definicion de los file descriptors
  int ifd = fileno(input_fp);
  int ofd = fileno(output_fp);
  /*Programa assembler que imprime en output todo los palindromos que lee de input*/
  //char* ret_val = palindrome(ifd, ib, ofd, ob);
  int ret_val = palindrome(ifd, ib, ofd, ob);
  /*Vuelve a C*/
  if (ret_val > 0) fprintf(stderr, "%s\n", PALINDROME_ERROR);
  if (ret_val == INPUT_MALLOC_ERROR) fprintf(stderr, "%s\n", INPUT_MALLOC_MESSAJE);
  if (ret_val == OUTPUT_MALLOC_ERROR) fprintf(stderr, "%s\n", OUTPUT_MALLOC_MESSAJE);
  if (ret_val == WRITE_ERROR) fprintf(stderr, "%s\n", WRITE_MESSAJE);
  if (ret_val == READ_ERROR) fprintf(stderr, "%s\n", READ_MESSAJE);

  return 0;
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

int process_params(int argc, char** argv, char** input_file, char** output_file, char** ibytes, char** obytes){
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
        {"ibuf-bytes", required_argument, 0, 'I'},
        {"obuf-bytes", required_argument, 0, 'O'},
        {0, 0, 0, 0}
      };
      /* getopt_long stores the option index here. */
      int option_index = 0;

      c = getopt_long(argc, argv, "hvc:i:o:I:O:", long_options, &option_index);

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
        case 'I':
          *ibytes = optarg;
          break;
        case 'O':
          *obytes = optarg;
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

void print_help(){
  printf("Usage:\n \
  \ttp0 -h\n \
  \ttp0 -v\n \
  \ttp0 [options]\nOptions:\n \
  \t-v, --version    \tPrint version and quit.\n \
  \t-h, --help       \tPrint help and quit.\n \
  \t-i, --input      \tPath to input file.\n \
  \t-o, --output     \tPath to output file. \
  \t-I, --ibuf-bytes \tByte-count of the input counter.\
  \t-O, --obuf-bytes \tByte-count of the output counter.\nExamples:\n \
  \ttp0 -i ~/input -o ~/output\n");
}

void print_version(){
  printf("tp1 [Guerrero - Schapira - De Rosa] v1.0\n");
}
