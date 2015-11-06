//
// user_interaction.i - SWIG interface
//

%module user_interaction

%{
	#include "../config.h"
	#include "user_interaction.hpp"
%}

%include "std_string.i"

%include "secu_string.i"

namespace libdar {
	// class user_interaction : public on_pool
	// {
	// 	public:
	// 		user_interaction();
	// 		virtual ~user_interaction() {};

	// 		virtual void pause(const std::string & message);
	// 		virtual bool pause2(const std::string & message);
	// 		void warning(const std::string & message);
	// 		virtual std::string get_string(const std::string & message, bool echo);
	// 		virtual secu_string get_secu_string(const std::string & message, bool echo);
	// 		virtual void listing(const std::string & flag,
	// 		     const std::string & perm,
	// 		     const std::string & uid,
	// 		     const std::string & gid,
	// 		     const std::string & size,
	// 		     const std::string & date,
	// 		     const std::string & filename,
	// 		     bool is_dir,
	// 		     bool has_children);
	// 		virtual void dar_manager_show_files(const std::string & filename,
	// 				    bool data_change,
	// 				    bool ea_change);
	// 		virtual void dar_manager_contents(U_I number,
	// 				  const std::string & chemin,
	// 				  const std::string & archive_name);
	// 		virtual void dar_manager_statistics(U_I number,
	// 				    const infinint & data_count,
	// 				    const infinint & total_data,
	// 				    const infinint & ea_count,
	// 				    const infinint & total_ea);

	// };

	// %feature("notabstract") user_interaction;

	class user_interaction_callback : public user_interaction
	{
		// %constant void x_warning_callback(const std::string &x, void *context);
		// %constant bool x_answer_callback(const std::string &x, void *context);
		// %constant std::string x_string_callback(const std::string &x, bool echo, void *context);
		// %constant secu_string x_secu_string_callback(const std::string &x, bool echo, void *context);

		%{
			struct st_context_py_func {
				PyObject *f1, *f2, *f3, *f4;
				void * context;
			};

			static void x_warning_callback(const std::string &x, void *context){
				st_context_py_func *ct = (st_context_py_func *) context;

				PyObject *func, *arglist;
				PyObject *result;

				func = (PyObject *) ct->f1;
				arglist = Py_BuildValue("(O)", PyUnicode_DecodeASCII(x.c_str(), strlen(x.c_str()), "strict") );
				result = PyEval_CallObject(func, arglist);
				Py_DECREF(arglist);

				Py_XDECREF(result);
				return;
			};

			static bool x_answer_callback(const std::string &x, void *context){
				bool rc = false;

				st_context_py_func *ct = (st_context_py_func *) context;

				PyObject *func, *arglist;
				PyObject *result;

				func = (PyObject *) ct->f2;
				arglist = Py_BuildValue("(O)", PyUnicode_DecodeASCII(x.c_str(), strlen(x.c_str()), "strict") );
				result = PyEval_CallObject(func, arglist);
				Py_DECREF(arglist);

				if ((result) && PyBool_Check(result) && ( result == Py_True )) {
					rc = true;
				}
				Py_XDECREF(result);

				return rc;
			};

			static std::string x_string_callback(const std::string &x, bool echo, void *context){

			};

			static libdar::secu_string x_secu_string_callback(const std::string &x, bool echo, void *context){

			};
		%}

		public:

			%typemap(python, in) PyObject *pyfunc1, PyObject *pyfunc2, PyObject *pyfunc3, PyObject *pyfunc4 {
				if (!PyCallable_Check($input)) {
					PyErr_SetString(PyExc_TypeError, "Need a callable object!");
					return NULL;
				}
				$1 = $input;
			}

			%extend {
				user_interaction_callback(
					PyObject *pyfunc1, 
					PyObject *pyfunc2, 
					PyObject *pyfunc3, 
					PyObject *pyfunc4)
					//void *context_value) - !!! нужно добавить что бы передавать аргументы из питона
				{
					st_context_py_func context;

					context.f1 = pyfunc1;
					context.f2 = pyfunc2;
					context.f3 = pyfunc3;
					context.f4 = pyfunc4;
					context.context = NULL;
					// context.context = context_value;

					return new libdar::user_interaction_callback(
						x_warning_callback,
						x_answer_callback,
						x_string_callback,
						x_secu_string_callback,
						(void *) &context);
				};
			}

			// user_interaction_callback(
			// 	void (*x_warning_callback)(const std::string &x, void *context),
			// 	bool (*x_answer_callback)(const std::string &x, void *context),
			// 	std::string (*x_string_callback)(const std::string &x, bool echo, void *context),
			// 	secu_string (*x_secu_string_callback)(const std::string &x, bool echo, void *context), 
			// 	void *context_value);

			std::string get_string(const std::string & message, bool echo);
			secu_string get_secu_string(const std::string & message, bool echo);
	};
}