#
# conditionnal part: --enable-mode=...
#

if BUILD_MODE32
    MYLIB=dar32
    AM_CPPFLAGS=-DLIBDAR_MODE=32 -I../../../libdar $(AX_SWIG_PYTHON_CPPFLAGS)
else
if BUILD_MODE64
    MYLIB=dar64
    AM_CPPFLAGS=-DLIBDAR_MODE=64 -I../../../libdar $(AX_SWIG_PYTHON_CPPFLAGS)
else
    MYLIB=dar
    AM_CPPFLAGS=-I../../../libdar $(AX_SWIG_PYTHON_CPPFLAGS)
endif
endif


if HAVE_SWIG

BUILD_LIBDIR = ../../..
SWIG_GENFLAGS = -I$(BUILD_LIBDIR)/libdar -I$(BUILD_LIBDIR) -I..

BUILT_SOURCES = libdar_wrap.cpp
SWIG_SOURCES = ../libdar.i

CLEANFILES =                \
        *.pyc               \
        *.pyo               \
        *.o                 \
        *.so                \
        libdar.py           \
        libdar_wrap.cpp

EXTRA_DIST =                \
        __init__.py

swigincludedir = $(includedir)/libdar/swig
swiginclude_HEADERS = $(SWIG_SOURCES) 
#../archive.i ../dar_types.i ../infinint.i ../mask.i ../path.i secu_string.i ../statistics.i ../user_interaction.i

libdar_PYTHON = __init__.py libdar.py

libdar_LTLIBRARIES = _libdar.la
nodist__libdar_la_SOURCES = libdar_wrap.cpp $(SWIG_SOURCES)
_libdar_la_LIBADD = $(top_builddir)/src/libdar/lib$(MYLIB).la
_libdar_la_LDFLAGS = $(PYTHON_LDFLAGS) -avoid-version -module
#_libdar_la_CFLAGS = $(PYTHON_CPPFLAGS) -I$(top_builddir)/src
libdardir = $(pyexecdir)/libdar

libdar_wrap.cpp : $(SWIG_SOURCES)
	$(SWIG) $(AX_SWIG_PYTHON_OPT) $(AM_CPPFLAGS) $(SWIG_GENFLAGS) -o $@ $<

endif # HAVE_SWIG
