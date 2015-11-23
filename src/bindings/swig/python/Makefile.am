#
# conditionnal part: --enable-mode=...
#

if BUILD_MODE32
    MYLIB=dar32
    AM_CPPFLAGS=-DLIBDAR_MODE=32 -I../libdar $(CPP_PROF)
else
if BUILD_MODE64
    MYLIB=dar64
    AM_CPPFLAGS=-DLIBDAR_MODE=64 -I../libdar  $(CPP_PROF)
else
    MYLIB=dar
    AM_CPPFLAGS=-I../libdar $(CPP_PROF)
endif
endif

BUILD_LIBDIR = ../../..
SWIG_DEFDIR = ..
SWIG_DEPS = 
#$(SWIG_DEFDIR)/dar_types.i $(BUILD_LIBDIR)/libdar/lib$(MYLIB).la
SWIG_GENFLAGS = -I$(BUILD_LIBDIR)/libdar -I$(BUILD_LIBDIR) -I..
SWIG_COMPFLAGS = $(SWIG_GENFLAGS) $(AX_SWIG_PYTHON_CPPFLAGS) $(AX_SWIG_PYTHON_LIBS) -DHAVE_CONFIG_H

#$(SWIG_PY_INCLUDES) 
# $(SWIG_PY_LIBS)


all-local : _libdar.so


libdar_wrap.cpp : $(SWIG_DEFDIR)/libdar.i $(SWIG_DEPS)
	$(SWIG) $(AX_SWIG_PYTHON_OPT) $(SWIG_GENFLAGS) -o $@ $^

libdar_wrap.o : libdar_wrap.cpp
	g++ -std=c++11 -fPIC -c $< $(SWIG_GENFLAGS) $(PYTHON_CPPFLAGS)

_libdar.so : libdar_wrap.o $(BUILD_LIBDIR)/libdar/.libs/statistics.o
	g++ -shared -o $@ $^ -l$(MYLIB) $(PYTHON_LIBS) -L$(BUILD_LIBDIR)/libdar/.libs


clean-local:
	rm -rf *.so *.o *.pyc libdar_wrap.cpp libdar.py
