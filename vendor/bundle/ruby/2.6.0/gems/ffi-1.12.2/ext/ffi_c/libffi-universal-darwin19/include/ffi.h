#if defined(__i386__)
#include "libffi-i386/include/ffi.h"
#elif defined(__x86_64__)
#include "libffi-x86_64/include/ffi.h"
#elif defined(__ppc__)
#include "libffi-ppc/include/ffi.h"
#endif
