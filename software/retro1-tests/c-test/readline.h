#ifndef _READLINE_H
#define _READLINE_H

#define INTERRUPTIBLE 1
#define NON_INTERRUPTIBLE 0

extern char * readline(unsigned char interruptible);
extern char readline_buffer[];
extern void readline_reedit(void);

#endif
