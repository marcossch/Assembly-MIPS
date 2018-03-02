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
#define INIT_WORD_SIZE 128
#define WORD_SIZE_INC 32

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

/*Lee el string entrante y lo devuelve.
 * @param fp: File Pointer de input
 * @param size: Tamaño inicial del arraglo, que se modifica con la entrada
 * @return: Devuelve el string leido.*/
char* read_input(FILE* fp, size_t size);
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
/*Se escriben los palíndromos en el archivo indicado.
 * @param output_fp: File Pointer del archivo a escribir.
 * @param result: String a escribir en el archivo.
 * @return: FAIL | SUCCESS.*/
int write_result(FILE* output_fp, char* result);
/*Cierra los dos archivos recibidos.
 * @param fp1, fp2: File Pointer de archivo a cerrar.*/
void close_files(FILE* fp1, FILE* fp2);
/*Invierte la cadena recibida.
 * @param str: Cadena de caracteres a invertir
 * @return: Cadena recibida, en orden inverso.*/
char* strrev(char* str);
/*Devuelve un arreglo listo para escribir en un archivo que contiene, uno en
cada linea, los palindromos del string recibido.
 * @param string: Cadena a analizar en busca de palindromos.
 * @return: Cadena que contiene solo palindromos, uno por linea.*/
char* get_palindromes(char* string);
/*Verifica si una cadena es un palindromo o no.
 * @param string: cadena a analizar
 * @return: True | False*/
bool is_palindrome(char* string);
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
int process_params(int argc, char** argv, char** input_file, char** output_file);

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
  char* input_string = read_input(input_fp, INIT_SIZE);
  if (!input_string){
    close_files(output_fp, input_fp);
    return READING_ERROR;
  }
  //Calculo de palindromos
  char* result_string = get_palindromes(input_string);
  free(input_string);
  if (!result_string){
    printf("%s\n", PALINDROME_ERROR_MESSAGE);
    close_files(input_fp, output_fp);
    return PALINDROME_ERROR;
  } else if (!strcmp(result_string, "\n")){ //Es el caso del archivo vacio!
    return SUCCESS;
  }
  //Escritura del resultado
  int written = write_result(output_fp, result_string);
  if (written == FAIL){
    close_files(input_fp, output_fp);
    if (result_string) free(result_string);
    return WRITING_ERROR;
  }
  //Se liberal la memoria del string
  if (result_string) free(result_string);
  //Se cierran los archivos
  close_files(input_fp, output_fp);

  return SUCCESS;
}

char* read_input(FILE* fp, size_t size){
  char* string;
  int char_;
  size_t len = 0; //Tamaño actual del arreglo

  //Arreglo inicial
  string = malloc(sizeof(char)*size);
  if (!string){
    printf("%s%s\n", ALLOC_ERROR, strerror(errno));
    return NULL;
  }
  //Ciclo principal
  while( EOF != (char_ = fgetc(fp)) ){
    string[len++] = char_; //Se suma uno a la longitud del string
    //Si el string alcanza el largo máximo, hay que redimensionar el arreglo
    if (len == size){
      string = realloc(string, sizeof(char)*(size += SIZE_INC));
      if (!string){
        printf("%s%s\n", REALLOC_ERROR, strerror(errno));
        return NULL;
      }
    }
  }
  //Fin de linea
  string[len++] = '\0';
  //Usamos solo la memoria necesaria!
  string = realloc(string, sizeof(char)*len);
  if (!string){
    printf("%s%s\n", REALLOC_ERROR, strerror(errno));
    return NULL;
  }
  return string;
}

int write_result(FILE* fp, char* result){
  //Se escribe el resultado
  int written = fprintf(fp, "%s", result);
  //Si no se logró escribir completo o hubo algún error, se notifica.
  if (written < 0){
    printf("%s%s\n", RESULT_WRITING_ERROR, strerror(errno));
    return FAIL;
  }
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

char* get_palindromes(char* string){
  int len = strlen(string) + 1;
  if (len < 1) return "\n";
  int init = 0;
  int cant = 0;
  //Arreglo donde se guardan las palabras individuales
  char* new = malloc(sizeof(char)*len);
  if (!new){
    printf("%s%s\n", ALLOC_ERROR, strerror(errno));
    return NULL;
  }

  //Arreglo para devolver, dinamico
  int size = len;
  char* return_array = malloc(sizeof(char)*size);
  if (!return_array){
    printf("%s%s\n", ALLOC_ERROR, strerror(errno));
    return NULL;
  }
  memset(return_array, 0, sizeof(char)*size);
  //Ciclo principal
  int i, j;
  for(i = 0; i < len; i++){
    int a = string[i];
    /*Si la letra actual corresponde a un caracter válido, seguimos con las
    siguiente*/
    if( a>47 && a<58 ) continue;
    if( (a>64 && a<91) || (a > 96 && a<123) ) continue;
    if( a == 95 || a==45 ) continue;

    //Si estamos aca es porque es un caracter que quivale al espacio.
    memset(new, 0, sizeof(char)*len); //Reseteamos el array
    for(j = 0; j < (i - init); j++){ //Copiamos la nueva palabra
      new[j] = string[init + j];
    }
    //En caso de ser capicua, la agregamos al string de palabras
    if(is_palindrome(new)){
      //Se agrega letra por letra
      for(j = 0; j < (i - init); j++){
        return_array[cant] = new[j];
        cant++;
        //En caso de alcanzar el limite, se redimensiona
        if (cant == size){
          return_array = realloc(return_array, sizeof(char)*(size += size/4) );
          if (!return_array){//Control de error
            printf("%s%s\n", REALLOC_ERROR, strerror(errno));
            return NULL;
          }
        }
      }
      //Fin de palabra
      return_array[cant] = '\n';
      cant++;
      //En caso de alcanzar el limite, se redimensiona
      if (cant == size){
        return_array = realloc(return_array, sizeof(char)*(size += size/4) );
        if (!return_array){//Control de error
          printf("%s%s\n", REALLOC_ERROR, strerror(errno));
          return NULL;
        }
      }
    }
    init = i + 1;
  }
  return_array[cant++] = '\0';
  free(new);
  //Usamos solo la memoria necesaria
  return_array = realloc(return_array, sizeof(char)*cant);
  if (!return_array){
    printf("%s%s\n", REALLOC_ERROR, strerror(errno));
    return NULL;
  }
  return return_array;
}

bool is_palindrome(char* string){
  /* Si tiene un solo caracter entonces es palindromo */
  int len = strlen(string) + 1;
  if (len < 1|| !strcmp(string,"")) return false;
  else if (len == 1) return true;
  /*Analizamos la palabra*/
  bool result = false;
  /*Pasamos a minuscula los caracteres*/
  int size = INIT_WORD_SIZE;
  char* lower = malloc(sizeof(char)*size);
  if (!lower){
    printf("%s%s\n", ALLOC_ERROR, strerror(errno));
    return false;
  }
  memset(lower, 0, sizeof(char)*size);
  //Pasamos a minuscula
  int i;
  for(i = 0; i < len; i++){
    if (i == size){
      lower = realloc(lower, sizeof(char)*(size += WORD_SIZE_INC) );
      if (!lower){//Control de error
        printf("%s%s\n", REALLOC_ERROR, strerror(errno));
        return false;
      }
    }
    lower[i] = tolower((unsigned char)string[i]);
  }
  lower[i] = '\0'; //Fin de cadena
  /*Verificamos si es capicua*/
  char* copy = malloc(sizeof(char)*size);
  if (!copy){
    printf("%s%s\n", ALLOC_ERROR, strerror(errno));
    free(lower);
    return false;
  }
  /*Se copia y se invierte*/
  strcpy(copy, lower);
  strrev(copy);
  if(!strcmp(lower, copy)) result = true;
  //Se liberan los strings usados
  free(lower);
  free(copy);

  return result;
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
