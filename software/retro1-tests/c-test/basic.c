#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#include "led.h"
#include "basic.h"
#include "acia.h"

#include "readline.h"
#include "interrupt.h"
#include "variables.h"
#include "utils.h"
#include "basic.h"
#include "debug.h"

void execute(char *s);
void print_ready(void);
void print_interrupted(void);

char *parse_number_expression(char *s, int *value);
char *parse_number_term(char *s, int *value);
char *parse_integer(char *s, int *value);
char *parse_string_expression(char *s, char **value);
char *parse_string(char *s, char *value);
char *parse_variable(char *s, unsigned int *name, unsigned char *type);
unsigned char next_token(char *s);
char *consume_token(char *s, unsigned char token);
char * skip_whitespace(char *s);
char * find_args(char *s);
unsigned char find_keyword(char *s);

void syntax_error_invalid_token(unsigned char token);
#define syntax_error_invalid_string() syntax_error_msg("Invalid string expression")
#define syntax_error_invalid_number() syntax_error_msg("Invalid number expression")
#define syntax_error_invalid_argument() syntax_error_msg("Invalid argument")

void delete_line(unsigned int line_number);
void create_line(unsigned int line_number, char *s);

void cmd_goto(char *args);
void cmd_run(char *args);
void cmd_led(char *args);
void cmd_print(char *args);
void cmd_put(char *args);
void cmd_list(char *args);
void cmd_new(char *args);
void cmd_free(char *args);
void cmd_load(char *args);
void cmd_sleep(char *args);
void cmd_let(char *args);
void cmd_input(char *args);
void cmd_seed(char *args);
void cmd_if(char *args);
void cmd_end(char *args);
void cmd_edit(char *args);
void cmd_rem(char *args);
void cmd_write(char *args);

// Basic command function type
typedef void (* command_function) (char *args);

// Basic command function table
const command_function command_functions[] = {
  cmd_goto,
  cmd_run,
  cmd_led,
  cmd_print,
  cmd_put,
  cmd_list,
  cmd_new,
  cmd_free,
  cmd_load,
  cmd_sleep,
  cmd_let,
  cmd_input,
  cmd_seed,
  cmd_if,
  cmd_end,
  cmd_edit,
  cmd_rem,
  cmd_write
};

// Basic command keyword table
const char *keywords[] = {
  "goto",
  "run",
  "led",
  "print",
  "put",
  "list",
  "new",
  "free",
  "load",
  "sleep",
  "home",
  "let",
  "input",
  "seed",
  "if",
  "end",
  "edit",
  "rem",
  "write",
  0
};

// Return value of find_keyword() if the keyword wasn't found
#define CMD_UNKNOWN 0xFF

// Buffer used for priting messages to the LCD
char print_buffer[41];

// Buffer used for language parsing
char parsebuf[256];

// Temporary buffer
char tmpbuf[256];

// Data structure holding one line of BASIC code
typedef struct _program_line {
  unsigned int number;
  unsigned char command;
  char * args;
  struct _program_line * next;
} program_line;

// Pointer to the first BASIC line
program_line * program = NULL;

// Current line during program execution
program_line * current_line;

// True if command has changed the current line
unsigned char current_line_changed;

// True if a program is running
unsigned char running = 0;

// True if an error occourred
unsigned char error = 0;

// Language tokens
#define TOKEN_INVALID       0
#define TOKEN_END           1
#define TOKEN_DIGITS        2
#define TOKEN_STRING        3
#define TOKEN_VAR_NUMBER    4
#define TOKEN_VAR_STRING    5
#define TOKEN_ASSIGN        6
#define TOKEN_PLUS          7
#define TOKEN_MINUS         8
#define TOKEN_MUL           9
#define TOKEN_DIV           10
#define TOKEN_MOD           11
#define TOKEN_COMMA         12
#define TOKEN_EQUAL         13
#define TOKEN_NOTEQUAL      14
#define TOKEN_LESS          15
#define TOKEN_LESSEQUAL     16
#define TOKEN_GREATER       17
#define TOKEN_GREATEREQUAL  18
#define TOKEN_THEN          19
#define TOKEN_ONERROR       20

// Descriptions of the tokens used in error messages
const char *token_strings[] = {
  "Unknown token", ";", "digits", "string", "number variable", "string variable",
  "=", "+", "-", "*", "/", "%", ",", "==", "!=",
  "<", "<=", ">", ">=", "then", "onerror"
};

/**
 * Initialize the BASIC interpreter.
 */
void basic_init() {
  init_builtin_variables();
}

/**
 * Interpret the input buffer 's'. This either executes the BASIC command in 's' or
 * creates a new program line containing the parsed command in 's'.
 */
void interpret(char *s) {
  char * command = s;
  unsigned int line_number;

  error = 0;
  current_line = 0;
  running = 0;

  if (strlen(s) == 0) {
    return;
  }

  if (isdigit(s[0])) {
    sscanf(s, "%u", &line_number);
    command = strchr(s, ' ');
    command = skip_whitespace(command);
    if (command) {
      create_line(line_number, (char *) command);
    } else {
      delete_line(line_number);
    }
  } else {
    execute((char *) command);
  }
}

/**
 * Execute the BASIC command in 's'.
 */
void execute(char *s) {
  unsigned char command;
  char * args;
  reset_interrupted();
  s = skip_whitespace(s);
  args = find_args(s);
  command = find_keyword(s);
  if (command != CMD_UNKNOWN) {
    command_functions[command](args);
  } else {
    acia_puts("Unknown command!\n");
  }
}

/**
 * Print "Ready."
 */
void print_ready() {
  if (! running) {
    acia_puts("Ready.\n");
  }
}

/**
 * Print "Interrupted."
 */
void print_interrupted() {
  acia_puts("Interrupted.\n");
}

/**
 * Parse a number expression 's' (that contains only number values) and return its
 * resulting value in 'value'.
 * Return a pointer behind the last character of the expression.
 * Return NULL if a syntax error occurred.
 */
char *parse_number_expression(char *s, int *value) {
  unsigned char token = next_token(s);

  if (token == TOKEN_DIGITS || token == TOKEN_PLUS || token == TOKEN_MINUS ||
      token == TOKEN_VAR_NUMBER) {
    int operand;
    if (s = parse_number_term(s, value)) {
      for (;;) {
        token = next_token(s);
        switch (token) {
          case TOKEN_PLUS:
          case TOKEN_MINUS:
          case TOKEN_MUL:
          case TOKEN_DIV:
          case TOKEN_MOD:
          case TOKEN_EQUAL:
          case TOKEN_LESS:
          case TOKEN_LESSEQUAL:
          case TOKEN_GREATER:
          case TOKEN_GREATEREQUAL:
            s = consume_token(s, token);
            if (s = parse_number_term(s, &operand)) {
              switch (token) {
                case TOKEN_PLUS:
                  *value += operand;
                  break;
                case TOKEN_MINUS:
                  *value -= operand;
                  break;
                case TOKEN_MUL:
                  *value *= operand;
                  break;
                case TOKEN_DIV:
                  *value /= operand;
                  break;
                case TOKEN_MOD:
                  *value %= operand;
                  break;
                case TOKEN_EQUAL:
                  *value = *value == operand;
                  break;
                case TOKEN_NOTEQUAL:
                  *value = *value != operand;
                  break;
                case TOKEN_LESS:
                  *value = *value < operand;
                  break;
                case TOKEN_LESSEQUAL:
                  *value = *value <= operand;
                  break;
                case TOKEN_GREATER:
                  *value = *value > operand;
                  break;
                case TOKEN_GREATEREQUAL:
                  *value = *value >= operand;
                  break;
              }
            }
            break;
          default:
            return s;
        }
      }
      return s;
    }
  } else if (token == TOKEN_STRING || token == TOKEN_VAR_STRING) {
    char *string;
    if (s = parse_string_expression(s, &string)) {
      token = next_token(s);
      if (token == TOKEN_EQUAL || token == TOKEN_NOTEQUAL ||
          token == TOKEN_LESS || token == TOKEN_LESSEQUAL ||
          token == TOKEN_GREATER || token == TOKEN_GREATEREQUAL) {
        s = consume_token(s, token);
        strcpy(tmpbuf, string);
        if (s = parse_string_expression(s, &string)) {
          switch (token) {
            case TOKEN_EQUAL:
              *value = strcmp(tmpbuf, string) == 0;
              break;
            case TOKEN_NOTEQUAL:
              *value = strcmp(tmpbuf, string) != 0;
              break;
            case TOKEN_LESS:
              *value = strcmp(tmpbuf, string) < 0;
              break;
            case TOKEN_LESSEQUAL:
              *value = strcmp(tmpbuf, string) <= 0;
              break;
            case TOKEN_GREATER:
              *value = strcmp(tmpbuf, string) > 0;
              break;
            case TOKEN_GREATEREQUAL:
              *value = strcmp(tmpbuf, string) >= 0;
              break;
          }
          return s;
        }
      } else {
        syntax_error_invalid_token(token);
      }
    }
  }
  return NULL;
}

/**
 * Parse the number term 's' and return its resulting value in 'value'.
 * Return a pointer behind the last character of the expression.
 * Return NULL if a syntax error occurred.
 */
char *parse_number_term(char *s, int *value) {
  unsigned char token;
  s = skip_whitespace(s);
  token = next_token(s);
  if (token == TOKEN_DIGITS || token == TOKEN_PLUS || token == TOKEN_MINUS) {
    if (s = parse_integer(s, value)) {
      return s;
    } else {
      syntax_error_invalid_number();
    }
  } else if (token == TOKEN_VAR_NUMBER) {
    unsigned int var_name;
    unsigned char var_type;
    variable *var;
    s = parse_variable(s, &var_name, &var_type);
    var = find_variable(var_name, VAR_TYPE_INTEGER, NULL);
    if (var) {
      *value = get_integer_variable_value(var);
      return s;
    } else {
      syntax_error_msg("Variable not found");
    }
  } else {
    syntax_error();
  }

  return NULL;
}

/**
 * Parse the string expression 's' (that contains only string values) and return its
 * resulting value in 'value'.
 * Return a pointer behind the last character of the expression.
 * Return NULL if a syntax error occurred.
 */
char *parse_string_expression(char *s, char **value) {
  unsigned int var_name;
  variable *var;
  unsigned char var_type;
  unsigned char token;

  s = skip_whitespace(s);
  token = next_token(s);

  if (token == TOKEN_STRING) {
    if (s = parse_string(s, parsebuf)) {
      *value = parsebuf;
      return s;
    } else {
      syntax_error_invalid_string();
    }
  } else if (token == TOKEN_VAR_STRING) {
    s = parse_variable(s, &var_name, &var_type);
    var = find_variable(var_name, VAR_TYPE_STRING, NULL);
    if (var) {
      *value = get_string_variable_value(var);
      return s;
    } else {
      syntax_error_msg("Variable not found");
    }
  } else {
    syntax_error();
  }

  return NULL;
}

/**
 * Parse a string argument ("...") at the beginning of the string pointed to by 's'.
 * If a string argument is found, it is copied to the buffer 'value' and a pointer
 * behind the string argument is returned from parse_string().
 * If no string argument is found, NULL is returned and 'value' is not modified.
 */
char *parse_string(char *s, char *value) {
  char *right_mark;
  s = skip_whitespace(s);
  if (*s == '"') {
    ++s;
    right_mark = strchr(s, '"');
    if (right_mark) {
      int len = right_mark - s;
      strncpy(value, s, len);
      *(value + len) = '\0';
      return right_mark + 1;
    }
  }
  return NULL;
}

/**
 * Parse an integer argument(+-0..9+) in the string pointed to by 's'.
 * If an integer argument is found, its value is returned in 'value' and a pointer
 * behind the integer argument is returned from parse_integer().
 * If no integer argument is found, NULL is returned.
 */
char *parse_integer(char *s, int *value) {
  s = skip_whitespace(s);
  if(*s == '+' || *s == '-' || isdigit(*s)) {
    sscanf(s, "%d", value);
    ++s;
    while (isdigit(*s)) {
      ++s;
    }
    return s;
  }
  return NULL;
}

/**
 * Parse a variable in the string 's' and return its name in 'name', its type
 * in 'type' and a pointer behind the variable.
 * If no variable is found, NULL is returned;
 */
char *parse_variable(char *s, unsigned int *name, unsigned char *type) {
  s = skip_whitespace(s);
  if (isalpha(*s)) {
    *name = *s;
    ++s;
    if (isalnum(*s)) {
      *name <<= 8;
      *name |= *s;
    }
    while (isalnum(*s)) { ++s; }
    if (*s == '$') {
      ++s;
      *type = VAR_TYPE_STRING;
    } else {
      *type = VAR_TYPE_INTEGER;
    }
    return s;
  }
  return NULL;
}

/**
 * Consume the token 'token' in the string 's'.
 * Return a pointer behind the token.
 * If the token wasn't found, return NULL with a syntax error.
 * Currently only implemented for operator tokens.
 */
char *consume_token(char *s, unsigned char token) {
  s = skip_whitespace(s);
  if ((token == TOKEN_ASSIGN && *s == '=') ||
      (token == TOKEN_PLUS && *s == '+') ||
      (token == TOKEN_MINUS && *s == '-') ||
      (token == TOKEN_MUL && *s == '*') ||
      (token == TOKEN_DIV && *s == '/') ||
      (token == TOKEN_MOD && *s == '%') ||
      (token == TOKEN_COMMA && *s == ',')) {
    return s + 1;
  } else if (token == TOKEN_ASSIGN && *s == '=' && *(s + 1) != '=') {
    return s + 1;
  } else if (token == TOKEN_EQUAL && *s == '=' && *(s + 1) == '=') {
    return s + 2;
  } else if (token == TOKEN_LESS && *s == '<' && *(s + 1) != '=') {
    return s + 1;
  } else if (token == TOKEN_LESSEQUAL && *s == '<' && *(s + 1) == '=') {
    return s + 2;
  } else if (token == TOKEN_GREATER && *s == '>' && *(s + 1) != '=') {
    return s + 1;
  } else if (token == TOKEN_GREATEREQUAL && *s == '>' && *(s + 1) == '=') {
    return s + 2;
  } else if (token == TOKEN_THEN && strncmp(s, "then", 4) == 0) {
    return s + 4;
  } else if (token == TOKEN_ONERROR && strncmp(s, "onerror", 7) == 0) {
    return s + 7;
  }
  syntax_error_invalid_token(next_token(s));
  return NULL;
}

/**
 * Get the token id of the first token in 's'.
 */
unsigned char next_token(char *s) {
  s = skip_whitespace(s);
  if(isdigit(*s)){
    return TOKEN_DIGITS;
  } else if (strncasecmp(s, "then", 4) == 0) {
    return TOKEN_THEN;
  } else if (strncasecmp(s, "onerror", 7) == 0) {
    return TOKEN_ONERROR;
  } else if (isalpha(*s)) {
    while (isalnum(*s)) { ++s; }
    if (*s == '$') {
      return TOKEN_VAR_STRING;
    } else {
      return TOKEN_VAR_NUMBER;
    }
  } else if (*s == '"') {
    return TOKEN_STRING;
  } else if (*s == '=') {
    ++s;
    if (*s == '=') {
      return TOKEN_EQUAL;
    }
    return TOKEN_ASSIGN;
  } else if (*s == '<') {
    ++s;
    if (*s == '=') {
      return TOKEN_LESSEQUAL;
    }
    return TOKEN_LESS;
  } else if (*s == '>') {
    ++s;
    if (*s == '=') {
      return TOKEN_GREATEREQUAL;
    }
    return TOKEN_GREATER;
  } else if (*s == '+') {
    return TOKEN_PLUS;
  } else if (*s == '-') {
    return TOKEN_MINUS;
  } else if (*s == '*') {
    return TOKEN_MUL;
  } else if (*s == '/') {
    return TOKEN_DIV;
  } else if (*s == '%') {
    return TOKEN_MOD;
  } else if (*s == ',') {
    return TOKEN_COMMA;
  } else if (*s == '\0' || *s == ';') {
    return TOKEN_END;
  }
  return TOKEN_INVALID;
}

/**
 * Skip any whitespace in the string pointed to by 's'.
 * Returns a pointer to the first non whitespace character.
 */
char *skip_whitespace(char *s) {
  while (*s == ' ') {
    ++s;
  }
  return s;
}

/**
 * Find the start of the arguments after the command in 's'.
 */
char *find_args(char *s) {
  char * args = s;
  while (*args && *args != ' ') {
    ++args;
  }
  return skip_whitespace(args);
}

/**
 * Find the keyword index of the command string 's'.
 * Returns CMD_UNKNOWN if no command was found.
 */
unsigned char find_keyword(char *s) {
  unsigned char index = 0;
  const char **keyword = keywords;
  while (*keyword) {
    if (strncasecmp(*keyword, s, strlen(*keyword)) == 0) {
      return index;
    }
    ++index;
    ++keyword;
  }
  return CMD_UNKNOWN;
}

/**
 * Print the error message 'msg' and set the error flag.
 */
void syntax_error_msg_with_arg(const char *msg, const char *msg_arg) {
  error = 1;
  if (current_line) {
    sprintf(print_buffer, "%u: ", current_line->number);
    acia_puts(print_buffer);
  }
  acia_puts(msg);
  if (msg_arg) {
    acia_puts(msg_arg);
  }
  acia_puts("!\n");
}

/**
 * Print the standard error message and set the error flag.
 */
void syntax_error() {
  syntax_error_msg("Syntax error");
}

void syntax_error_invalid_token(unsigned char token) {
  const char *token_string = token_strings[token];
  syntax_error_msg_with_arg("Invalid token: ", token_string);
}

/**
 * Selete the program line with number 'number'.
 */
void delete_line(unsigned int number) {
  program_line *prev_line = 0;
  program_line *line = program;
  while (line) {
    if (line->number == number) {
      if (prev_line) {
        prev_line->next = line->next;
      } else {
        program = line->next;
      }
      free(line->args);
      free(line);
      break;
    }
    prev_line = line;
    line = line->next;
  }
}

/**
 * Create a new program line with number 'number' and the command in 's'.
 */
void create_line(unsigned int number, char *s) {
  unsigned char command;
  char * args;
  program_line * new_line;
  args = find_args(s);
  command = find_keyword(s);
  if (command != CMD_UNKNOWN) {
    delete_line(number);
    new_line = malloc(sizeof(program_line));
    new_line->number = number;
    new_line->command = command;
    new_line->args = malloc(strlen(args) + 1);
    strcpy(new_line->args, args);
    if (program && number > program->number) {
      program_line *line = program;
      while (line->next && number > line->next->number) {
        line = line->next;
      }
      new_line->next = line->next;
      line->next = new_line;
    } else {
      new_line->next = program;
      program = new_line;
    }
  } else {
    acia_puts("Unknown command!\n");
  }
}

/**
 * Enable/Disable the LED.
 * LET ON|OFF
 */
void cmd_led(char *args) {
  if (strcmp("on", args) == 0) {
    led_set(1);
  } else if (strcmp("off", args) == 0) {
    led_set(0);
  } else {
    syntax_error();
  }
}

/**
 * Print a string constant or a variable value (no newline).
 * PUT <expression>
 */
void cmd_put(char *args) {
  int number_value;
  char *string_value;
  unsigned char token;
  while (! error) {
    token = next_token(args);
    if (token == TOKEN_STRING || token == TOKEN_VAR_STRING) {
      if (args = parse_string_expression(args, &string_value)) {
        acia_puts(string_value);
      }
    } else if (token == TOKEN_DIGITS || token == TOKEN_PLUS || token == TOKEN_MINUS ||
               token == TOKEN_VAR_NUMBER) {
      if (args = parse_number_expression(args, &number_value)) {
        sprintf(print_buffer, "%d", number_value);
        acia_puts(print_buffer);
      }
    } else if (token == TOKEN_COMMA) {
      args = consume_token(args, token);
    } else if (token == TOKEN_END) {
      return;
    } else {
      syntax_error();
      return;
    }
  }
}

/**
 * Does a print and then a newline.
 */
void cmd_print(char *args) {
  cmd_put(args);
  if (! error) {
    acia_put_newline();
  }
}

/**
 * List the program.
 * LiST [<from>]
 */
void cmd_list(char *args) {
  unsigned char range = 0;
  unsigned int from_number;
  unsigned int to_number;
  program_line *line;
  unsigned char first = 1;

  if (isdigit(args[0])) {
    sscanf(args, "%u", &from_number);
    to_number = from_number;
    range = 1;
  }

  line = program;
  while (line) {
    if (range == 0 || (line->number >= from_number && line->number <= to_number)) {
      if (first) {
        first = 0;
      } else {
        /*do {
          if (is_interrupted()) {
            print_interrupted();
            return;
          }
          //keys_update();
        } while (keys_get_code() == KEY_NONE);*/
      }
      sprintf(print_buffer, "%u %s %s\n", line->number, keywords[line->command], line->args);
      acia_puts(print_buffer);
    }
    line = line->next;
  }

  print_ready();
}

/**
 * Run the program.
 * RUN
 */
void cmd_run(char *) {
  unsigned char command;
  error = 0;
  running = 1;
  current_line = program;
  current_line_changed = 0;
  while (current_line) {
    if (is_interrupted()) {
      print_interrupted();
      //lcd_cursor_blink();
      break;
    }
    command = current_line->command;
    command_functions[command](current_line->args);
    if (error) {
      break;
    }
    if (current_line_changed) {
      current_line_changed = 0;
      if (! current_line) {
        break;
      }
    } else {
      current_line = current_line->next;
    }
  }
  print_ready();
}

/**
 * Jump to another program line.
 * GOTO <line>
 */
void cmd_goto(char *args) {
  unsigned int line_number;
  program_line *line;
  if (isdigit(args[0])) {
    sscanf(args, "%u", &line_number);
    line = program;
    while (line) {
      if (line->number == line_number) {
        current_line = line;
        current_line_changed = 1;
        return;
      }
      line = line->next;
    }
    syntax_error_msg("Line not found");
  } else {
    syntax_error();
  }
}

/**
 * Clear the program and the variables.
 */
void cmd_new(char *args) {
  program_line * line = program;
  while (line) {
    program_line * next = line->next;
    free(line->args);
    free(line);
    line = next;
  }
  program = 0;
  //cmd_clear(args);
}

/**
 * Print the number of free RAM bytes.
 * FREE
 */
void cmd_free(char *) {
  sprintf(print_buffer, "%u bytes free.\n", _heapmemavail());
  acia_puts(print_buffer);
}

/**
 * Save a program by sending it to the terminal program over the serial line.
 * SAVE "<filename>"
 */
 /*
void cmd_save(char *args) {
  char *filename;
  if (parse_string_expression(args, &filename)) {
    program_line *line = program;
    acia_puts("Saving...");
    acia_puts("*SAVE \"");
    acia_puts(filename);
    acia_puts("\"\n");
    while (line) {
      sprintf(print_buffer, "%u %s %s\n", line->number, keywords[line->command], line->args);
      acia_puts(print_buffer);
      line = line->next;
      acia_putc('.');
    }
    acia_puts("*EOF\n");
    acia_put_newline();
    print_ready();
  } else {
    syntax_error_invalid_argument();
  }
}*/

/**
 * Load a program by reading it from the terminal program over the serial line.
 * LOAD "<filename>"
 */
void cmd_load(char *args) {
  char *filename;
  if (parse_string_expression(args, &filename)) {
    cmd_new(0);
    acia_puts("Loading...");
    acia_puts("*LOAD \"");
    acia_puts(filename);
    acia_puts("\"\n");
    for(;;) {
      acia_puts("*NEXT\n");
      acia_gets(readline_buffer, 255);
      if (strncmp("*EOF", readline_buffer, 4) == 0) {
        break;
      } else if (strncmp("!NOTFOUND", readline_buffer, 9) == 0) {
        acia_put_newline();
        syntax_error_msg("File not found");
        break;
      } else {
        acia_putc('.');
        interpret(readline_buffer);
      }
    }
    if (! error) {
      acia_put_newline();
      print_ready();
    }
  } else {
    syntax_error_invalid_argument();
  }
}

/**
 * List all programs stored on the terminal host over the serial line.
 * DIR
 *//*
void cmd_dir(char *) {
  unsigned char first = 1;

  acia_puts("*DIR\n");

  for(;;) {
    acia_puts("*NEXT\n");
    acia_gets(readline_buffer, 255);

    if (strncmp("*EOF", readline_buffer, 4) == 0) {
      break;
    } else {
      if (first) {
        first = 0;
      } else {
        do {
          if (is_interrupted()) {
            acia_puts("*BREAK\n");
            print_interrupted();
            return;
          }
         // keys_update();
        } while (keys_get_code() == KEY_NONE);
      }

      acia_puts(readline_buffer);
      acia_put_newline();
    }
  }
  print_ready();
}*/

/**
 * Pause the program for some specified amount of time.
 * SLEEP <milliseconds>
 */
void cmd_sleep(char *args) {
  static unsigned long delay;
  static unsigned long sleep_end_millis;
  if (isdigit(args[0])) {
    sscanf(args, "%ul", &delay);
    sleep_end_millis = time_millis() + delay;
    while (time_millis() < sleep_end_millis) {
      if (is_interrupted()) {
        break;
      }
    }
  } else {
    syntax_error();
  }
}


/**
 * Assign a value to a variable or delete the variable if no assignment is given.
 * List all variables if no arguments are given.
 */
void cmd_let(char *args) {
  unsigned char token;
  unsigned int var_name;
  unsigned char var_type;

  skip_whitespace(args);

  if (*args == '\0') {
    print_all_variables();
    print_ready();
    return;
  }

  if (args = parse_variable(args, &var_name, &var_type)) {
    if (next_token(args) == TOKEN_ASSIGN) {
      token = next_token(args);
      args = consume_token(args, token);
      switch (var_type) {
        case VAR_TYPE_INTEGER: {
          int value;
          if (parse_number_expression(args, &value)) {
            create_variable(var_name, var_type, &value);
          }
          break;
        }
        case VAR_TYPE_STRING: {
          char *value;
          if (parse_string_expression(args, &value)) {
            create_variable(var_name, var_type, value);
          }
          break;
        }
      }
    } else {
      if (*args == '\0') {
        delete_variable(var_name, var_type);
      }
    }
  } else {
    syntax_error();
  }
}

/**
 * Delete all variables.
 */
void cmd_clear(char *) {
  clear_variables();
  print_ready();
}

/**
 * Input a variable from the keyboard.
 * INPUT <variable> [ONERROR <command]
 */
void cmd_input(char *args) {
  unsigned int var_name;
  unsigned char var_type;

  args = parse_variable(args, &var_name, &var_type);
  if (args) {
    if (var_type == VAR_TYPE_STRING) {
      char *line = readline(INTERRUPTIBLE);
      create_variable(var_name, var_type, line);
    } else if (var_type == VAR_TYPE_INTEGER) {
      for (;;) {
        int value = 0;
        char *line = readline(INTERRUPTIBLE);
        if (is_interrupted()) {
          break;
        }
        if (parse_integer(line, &value)) {
          create_variable(var_name, var_type, &value);
          break;
        } else {
          if (next_token(args) == TOKEN_ONERROR) {
            args = consume_token(args, TOKEN_ONERROR);
            execute(args);
            break;
          } else {
            syntax_error_invalid_number();
            acia_puts("Enter again: ");
          }
        }
      }
    } else {
      syntax_error_invalid_argument();
    }
  } else {
    syntax_error_invalid_argument();
  }
}





/**
 * Seed the random number generator (e.g. SEED TI).
 * SEED <number>
 */
void cmd_seed(char *args) {
  int seed;
  if (parse_number_expression(args, &seed)) {
    srand(seed);
  }
}

/**
 * Conditional execution of a command.
 * IF <condition> THEN <command>
 */
void cmd_if(char *args) {
  int condition;
  if (args = parse_number_expression(args, &condition)) {
    if (condition) {
      if (args = consume_token(args, TOKEN_THEN)) {
        execute(args);
      }
    }
  }
}

/**
 * Terminate the program.
 * END
 */
void cmd_end(char *) {
  if (! current_line) {
    print_ready();
  }
  current_line = 0;
  current_line_changed = 1;
}

/**
 * Edit the specified program line.
 * EDIT <line>
 */
void cmd_edit(char *args) {
  unsigned int line_number;
  program_line *line;
  if (isdigit(args[0])) {
    sscanf(args, "%u", &line_number);
    line = program;
    while (line) {
      if (line->number == line_number) {
        sprintf(readline_buffer, "%u %s %s", line->number, keywords[line->command], line->args);
        readline_reedit();
        return;
      }
      line = line->next;
    }
    syntax_error_msg("Line not found");
  } else {
    syntax_error();
  }
}

/**
 * Comment a line. The argument is ignored, this command does nothing.
 * REM <comment>
 */
void cmd_rem(char *) {
}

/**
 * Write a character (first character of the evaluated string) at the current cursor
 * position. Do not move the cursor.
 * WRITE "<string expression>"
 */
void cmd_write(char *args) {
  char *value;
  if (parse_string_expression(args, &value)) {
    if (strlen(value) > 0) {
      //lcd_write(value[0]);
      acia_puts(value[0]);
    } else {
      syntax_error_invalid_argument();
    }
  }
}
