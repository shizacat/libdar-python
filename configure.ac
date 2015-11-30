#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([LIBDAR-PYTHON], [1.0.0], [test@test.ru])
AM_INIT_AUTOMAKE([subdir-objects])
AC_CONFIG_SRCDIR([src/])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_MACRO_DIR([m4])

# Scripting and Bindings languages
AM_PATH_PYTHON(3)
AX_PKG_SWIG(2.0, [], [ AC_MSG_ERROR([SWIG is required to build..]) ])
AX_SWIG_ENABLE_CXX
AX_SWIG_PYTHON


# Checks for programs.
AC_PROG_CXX
AC_PROG_CC
AC_PROG_LIBTOOL
AC_PROG_MAKE_SET
AC_PROG_RANLIB
AX_CXX_COMPILE_STDCXX([11], [noext])

AC_DEFINE(_DARWIN_C_SOURCE, 1, [Define on Darwin to activate all library features])

# Checks for libraries.
PKG_CHECK_MODULES(libdar64, libdar64 >= 4.8.0)

# Checks for header files.
AC_HEADER_STDC
AC_CHECK_HEADERS([dar/libdar.hpp])

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.


build_mode=64
#AC_ARG_ENABLE(	[mode],
#				AC_HELP_STRING(--enable-mode=arg, [where arg is 32 or 64. Makes dar internally use 32 bits or 64 bits integers in place of infinint (which is the case if this option is not given)]),
#				[build_mode=$enableval],
#				[])

AC_ARG_WITH(	[python],
				AS_HELP_STRING([--with-python],[build python bindings for libdar]),
				python_binding="$withval",
				python_binding="yes"
			)

AM_CONDITIONAL([HAVE_SWIG], [test -n "${SWIG}" ])

# for now, MAKE_BINDINGS is true if swig is being built (it's the only binding now)
AM_CONDITIONAL([MAKE_BINDINGS], [test $python_binding = "yes"])
#AM_CONDITIONAL([MAKE_SWIG], [test "$SWIG_SUITABLE" = "yes"])
AM_CONDITIONAL([MAKE_SWIG_PYTHON], [test $python_binding = "yes"])

AM_CONDITIONAL([BUILD_MODE32], [test "$build_mode" = "32"])
AM_CONDITIONAL([BUILD_MODE64], [test "$build_mode" = "64"])
AC_SUBST([CXXSTDFLAGS], [$CXXSTDFLAGS])

AC_CONFIG_FILES([Makefile
				 src/Makefile
                 src/bindings/Makefile
                 src/bindings/swig/Makefile
                 src/bindings/swig/python/Makefile])
AC_OUTPUT

echo "
Configuration for $PACKAGE $VERSION:
------------------------------------------

  Install prefix: .........: $prefix
  Debug code ..............: $building_debug_code
  Dev tools ...............: $building_dev_tools
  Python bindings .........: $python_bindings

  Build mode ..............: $build_mode

  Now type 'make' to build $PACKAGE $VERSION,
  and then 'make install' for installation.
"