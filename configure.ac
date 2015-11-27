# Process this file with autoconf to produce a configure script.

AC_PREREQ(2.69)
AC_INIT([LIBDAR-PYTHON], [1.0.0], test@test.ru)
#AM_INIT_AUTOMAKE
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

# Checks for libraries.
PKG_CHECK_MODULES(libdar, libdar >= 4.8.0)

# Checks for header files.
AC_CHECK_HEADERS([libdar/libdar.hpp])

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


AC_CONFIG_FILES([Makefile src/Makefile src/bindings/Makefile src/bindings/swig/Makefile src/bindings/swig/python/Makefile])
AC_OUTPUT

echo "
Configuration for $PACKAGE $VERSION:
------------------------------------------

  Install prefix: .........: $prefix
  Debug code ..............: $building_debug_code
  Dev tools ...............: $building_dev_tools
  Python bindings .........: $python_bindings

  Now type 'make' to build $PACKAGE $VERSION,
  and then 'make install' for installation.
"