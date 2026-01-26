#include "include/obj_encoding.h"

extern "C" {

__attribute__((visibility("default"))) __objsan::SmallObjectsTy __objsan_SmallObjects;
__attribute__((visibility("default"))) __objsan::LargeObjectsTy __objsan_LargeObjects;

};

namespace __objsan {

#ifdef STATS
#ifndef __OBJSAN_DEVICE__
__attribute__((visibility("default"))) StatsTy SLoads("loads");
__attribute__((visibility("default"))) StatsTy SStores("stores");
__attribute__((visibility("default"))) StatsTy SRange("range");
__attribute__((visibility("default"))) StatsTy SLoopR("loopr");
#endif
#endif

} // namespace __objsan

extern "C" {
using CtorFn = void (*)(void);
extern CtorFn __objsan_start_ctor;
extern CtorFn __objsan_stop_ctor;

#ifndef __OBJSAN_DEVICE__
__attribute__((constructor(1000))) void __objsan_ctor_init() {
    fprintf(stderr, "CTOR INIT  %p %p, %lu\n", &__objsan_start_ctor,
            &__objsan_stop_ctor,
            &__objsan_stop_ctor - &__objsan_start_ctor);
  for (CtorFn *Ctor = &__objsan_start_ctor, *E = &__objsan_stop_ctor;
       Ctor != E; ++Ctor)
    (*Ctor)();
  for (CtorFn *Ctor = &__objsan_start_ctor, *E = &__objsan_stop_ctor;
       Ctor != E; ++Ctor)
    (*Ctor)();
}
#endif
}
