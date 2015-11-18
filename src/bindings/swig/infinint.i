//
// infinint.i - SWIG interface
//

%module infinint
%{
	#include "../config.h"
	// #include <inttypes.h>
	#include "real_infinint.hpp"
%}

%include "dar_types.i"


// 	// #include <typeinfo>

// 	// #include "storage.hpp"
// 	// #include "integers.hpp"
// 	// #include "int_tools.hpp"
// 	// #include "on_pool.hpp"

// 	#define ZEROED_SIZE 50

// 	// class generic_file;
//     // class user_interaction;

// %ignore libdar::infinint::infinint_from<unsigned long>(unsigned long);
// %ignore libdar::infinint_from(unsigned long);
// %ignore libdar::infinint::detruit();


namespace libdar {
	// class infinint;

	class infinint : public on_pool
	{
		public :
			infinint(off_t a = 0);
			infinint(const infinint & ref);

		private :
			template <class T> void infinint_from(T a);
			
			// ~infinint();

			// void dump(generic_file &x) const;
			// void read(generic_file &f) { detruit(); build_from_file(f); };
			// template <class T> infinint power(const T & exponent) const;
			// template <class T> void unstack(T &v) { infinint_unstack_to(v); }
			// infinint get_storage_size() const { return field->size(); };
			// bool is_zero() const;
			// friend void euclide(infinint a, const infinint &b, infinint &q, infinint &r);
			// static bool is_system_big_endian();
	};
}


// namespace libdar {
// 	static endian infinint::used_endian = not_initialized;
// }

// %ignore libdar::operator +(const infinint &, const infinint &);
// %ignore libdar::operator - (const infinint &, const infinint &);
// %ignore libdar::operator * (const infinint &, const infinint &);
// %ignore libdar::operator * (const infinint &, const unsigned char);
// %ignore libdar::operator * (const unsigned char, const infinint &);
// %ignore libdar::operator / (const infinint &, const infinint &);
// %ignore libdar::operator % (const infinint &, const infinint &);
// %ignore libdar::operator & (const infinint & a, const infinint & bit);
// %ignore libdar::operator | (const infinint & a, const infinint & bit);
// %ignore libdar::operator ^ (const infinint & a, const infinint & bit);
// %ignore libdar::operator >> (const infinint & a, U_32 bit);
// %ignore libdar::operator >> (const infinint & a, const infinint & bit);
// %ignore libdar::operator << (const infinint & a, U_32 bit);
// %ignore libdar::operator << (const infinint & a, const infinint & bit);
// %ignore libdar::euclide(infinint a, const infinint &b, infinint &q, infinint &r);

// %ignore libdar::infinint::operator /= (const infinint & ref);
// %ignore libdar::infinint::operator %= (const infinint & ref);

// %ignore libdar::infinint::operator^=(infinint const&);
// %ignore libdar::infinint::operator<<=(unsigned int);
// %ignore libdar::infinint::operator<<=(infinint);
// %ignore libdar::infinint::operator-=(infinint const&);
// %ignore libdar::infinint::operator*=(unsigned char);
// %ignore libdar::infinint::operator*=(infinint const&);
// %ignore libdar::infinint::operator|=(infinint const&);
// %ignore libdar::infinint::operator+=(infinint const&);
// %ignore libdar::infinint::operator>>=(unsigned int);
// %ignore libdar::infinint::operator>>=(infinint);

// %ignore libdar::infinint::dump(generic_file &x) const;
// %ignore libdar::infinint::read(generic_file &f);

// %include "real_infinint.hpp"

// namespace libdar {
// 	// %template(infinint_u8) infinint<U_8>;
// 	%template(infinint_power_u8) infinint::power<U_8>;
// 	%template(infinint_modulo_u8) infinint::modulo<U_8>;
// 	%template(infinint_infinint_from_u8) infinint::infinint_from<U_8>;
// 	%template(infinint_max_val_of_u8) infinint::max_val_of<U_8>;
// 	%template(infinint_infinint_unstack_to_u8) infinint::infinint_unstack_to<U_8>;
	
// }

// %template(infinint_from_u8) infinint::infinint_from<U_8>
%template(infinint_from_u8) libdar::infinint::infinint_from<libdar::U_8>;
%template(infinint_from_ul) libdar::infinint::infinint_from<unsigned long>;
