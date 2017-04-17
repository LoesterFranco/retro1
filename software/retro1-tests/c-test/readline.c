#include <string.h>
#include "readline.h"
#include "interrupt.h"
#include "debug.h"
#include "acia.h"

void insert_character(char c);
void delete_prev_character(void);
void delete_character(void);
void delete_all_characters(void);
void cursor_left(void);
void cursor_right(void);
void cursor_start(void);
void cursor_end(void);

// Maximum number of characters in the input buffer
#define MAX_CHARS 79

// Input buffer
char readline_buffer[MAX_CHARS + 1];

// A pointer to the last valid character in the input buffer
char *buffer_end;

// A pointer to the cursor position in the input buffer
char *buffer_pos;

// If true the next call to readline() re-displays the input buffer
unsigned char reedit = 0;

/**
 * Lets the user edit an input line with MAX_CHARS characters.
 * A Pointer to the input line buffer is returned from readline().
 * If interruptible is true, the input can be canceled with an NMI.
 */
char * readline(unsigned char interruptible) {
 // unsigned char last_key = KEY_NONE;
  char last_char;
  unsigned char last_modifiers;
  reset_interrupted();

  if (reedit) {
    reedit = 0;
  } else {
    *readline_buffer = '\0';
    buffer_pos = readline_buffer;
    buffer_end = readline_buffer;
  }

  for (;;) {
    if (interruptible && is_interrupted()) {
      //lcd_put_newline();
      acia_put_newline();
      return readline_buffer;
    }

    //keys_update();

    //if (keys_get_code() != KEY_NONE) {
      //if (last_key == KEY_NONE) {
        //last_key = keys_get_code();
        //last_char = keys_getc();
        last_char = acia_getc();
        insert_character(last_char);
        /*
        last_modifiers = keys_get_modifiers();
        
        if (last_char == '\n') {
          lcd_put_newline();
          break;
        } else if ((last_key) == KEY_BACKSPACE) {
          delete_prev_character();
        } else if ((last_key) == KEY_DELETE) {
          delete_character();
        } else if (last_key == KEY_CURSOR_LEFT) {
          cursor_left();
        } else if (last_key == KEY_CURSOR_RIGHT) {
          cursor_right();
        } else if (last_key == KEY_HOME ||
                  (last_modifiers == MODIFIER_CTRL && last_key == KEY_A)) {
          cursor_start();
        } else if (last_key == KEY_END ||
                  (last_modifiers == MODIFIER_CTRL && last_key == KEY_E)) {
          cursor_end();
        } else if (last_modifiers == MODIFIER_CTRL && last_key == KEY_U) {
          delete_all_characters();
        } else if (last_char != 0) {
          insert_character(last_char);
        }
      }
    } else {
      last_key = KEY_NONE;
    }*/
  }

  return readline_buffer;
}

/**
 * Insert the character c at the current cursor position.
 * Move all following characters to the right.
 */
void insert_character(char c) {
  if (buffer_end - readline_buffer < MAX_CHARS) {
    /*if (buffer_pos < buffer_end) {
      unsigned x = lcd_get_x();
      unsigned y = lcd_get_y();
      char *pos = buffer_pos;
      while (pos <= buffer_end) {
        char old_c = *pos;
        lcd_putc(c);
        *pos = c;
        c = old_c;
        ++pos;
      }
      if (buffer_end - readline_buffer >= 39) {
        if (buffer_end - readline_buffer == 39) {
          lcd_goto(x + 1, y - 1);
        } else {
          if (x == 39) {
            lcd_goto(0, y +1);
          } else {
            lcd_goto(x + 1, y);
          }
        }
      } else {
        lcd_goto(x + 1, y);
      }
    } else {
      lcd_putc(c);
      *buffer_pos = c;
    }*/
    acia_putc(c);
    ++buffer_pos;
    ++buffer_end;
    *buffer_end = '\0';
  }
}

/**
 * Delete the character at the cursor position.
 * Move all following  characters to the left.
 */
void delete_prev_character() {
  if (buffer_pos > readline_buffer) {
    if (buffer_pos == buffer_end) {
      --buffer_pos;
      --buffer_end;
      *buffer_pos = '\0';/*
      if (lcd_get_x() == 0) {
        lcd_goto(39, lcd_get_y() - 1);
        lcd_putc(' ');
        lcd_goto(39, lcd_get_y() - 1);
      } else {
        lcd_goto(lcd_get_x() - 1, lcd_get_y());
        lcd_putc(' ');
        lcd_goto(lcd_get_x() - 1, lcd_get_y());
      }*/
    } else {
      /*char * pos;
      unsigned x = lcd_get_x();
      unsigned y = lcd_get_y();
      if (x == 0) {
        x = 39; y -= 1;
      } else {
        x -= 1;
      }
      lcd_goto(x, y);
      pos = buffer_pos;
      while (pos < buffer_end) {
        lcd_putc(*pos);
        *(pos - 1) = *pos;
        ++pos;
      }
      lcd_putc(' ');*/
      --buffer_pos;
      --buffer_end;
      *buffer_end = '\0';
      //lcd_goto(x, y);
    }
  }
}

/**
 * Delete the character left to the cursor.
 * Move the character at the cursor and all following  characters
 * to the left.
 */
void delete_character() {
  if (buffer_pos < buffer_end) {
    /*char *pos;
    unsigned x = lcd_get_x();
    unsigned y = lcd_get_y();
    pos = buffer_pos + 1;
    while (*pos) {
      char c = *(pos);
      lcd_putc(c);
      *(pos - 1) = c;
      ++pos;
    }
    lcd_putc(' ');*/
    acia_putc(' ');
    --buffer_end;
    *buffer_end = '\0';
    //lcd_goto(x, y);
  }
}

/**
 * Clear the input buffer.
 */
void delete_all_characters() {
  while (buffer_pos != readline_buffer) {
    delete_prev_character();
  }
}

/**
 * Move the cursor one position to the left.
 */
void cursor_left() {
  if (buffer_pos > readline_buffer) {
    --buffer_pos;/*
    if (lcd_get_x() == 0) {
      lcd_goto(39, lcd_get_y() - 1);
    } else {
      lcd_goto(lcd_get_x() - 1, lcd_get_y());
    }*/
  }
}

/**
 * Move the cursor one position to the right.
 */
void cursor_right() {
  if (buffer_pos < buffer_end) {
    ++buffer_pos;/*
    if (lcd_get_x() == 39) {
      lcd_goto(0, lcd_get_y() + 1);
    } else {
      lcd_goto(lcd_get_x() + 1, lcd_get_y());
    }*/
  }
}

/**
 * Move the cursor to the beginning of the input line.
 */
void cursor_start() {
  while (buffer_pos > readline_buffer) {
    cursor_left();
  }
}

/**
 * Move the cursor to the end of the input line.
 */
void cursor_end() {
  while (buffer_pos < buffer_end) {
    cursor_right();
  }
}

/**
 * Next time readline() is called, do not delete the input buffer.
 * Instead let the user edit the old buffer.
 */
void readline_reedit() {
  //lcd_puts(readline_buffer);
  acia_puts(readline_buffer);
  buffer_pos = readline_buffer + strlen(readline_buffer);
  buffer_end = buffer_pos;
  reedit = 1;
}
