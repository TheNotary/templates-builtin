#include "foo_bar.h"

VALUE rb_mFooBar;

void
Init_foo_bar(void)
{
  rb_mFooBar = rb_define_module("FooBar");
}
