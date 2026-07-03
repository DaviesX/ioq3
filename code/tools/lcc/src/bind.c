#include "tools/lcc/src/c.h"
extern Interface nullIR;
extern Interface bytecodeIR;
Binding bindings[] = {
    {"null", &nullIR},
    {"bytecode", &bytecodeIR},
    {NULL, NULL},
};
