#include "fast_ruby_identicon.h"
#include <stdio.h>
static VALUE rb_mFastRubyIdenticon;
static VALUE rb_class_siphash;

static uint8_t SPEC_KEY[16] = {
   0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
   0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff
};

static
VALUE rb_siphash2_digest(VALUE self, VALUE obj)
{
    StringValue(obj);
    char * ptr = StringValueCStr(obj);
    //printf("%llu\n", sip_hash24(SPEC_KEY, (uint8_t*) ptr, strlen(ptr)));
    return ULONG2NUM(sip_hash24(SPEC_KEY, (uint8_t*)ptr, strlen(ptr)));
}

void
Init_ext_fast_ruby_identicon(void)
{
  rb_mFastRubyIdenticon = rb_define_module("FastRubyIdenticon");
  rb_class_siphash = rb_define_class_under(rb_mFastRubyIdenticon, "SipHash", rb_cObject);
  rb_define_singleton_method(rb_class_siphash, "digest", rb_siphash2_digest, 1);
}
